import 'package:fintrack/core/utils/currency_formatter.dart';
import 'package:fintrack/domain/entities/transaction_entity.dart';
import 'package:fintrack/domain/repositories/transaction_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'export_event.dart';
import 'export_state.dart';

class ExportBloc extends Bloc<ExportEvent, ExportState> {
  final TransactionRepository repository;

  ExportBloc({required this.repository}) : super(ExportInitial()) {
    on<ExportToPdfRequested>((event, emit) async {
      emit(ExportLoading());
      try {
        final allTransactions = await repository.getAllTransactions();
        final transactions = _filterTransactions(
          allTransactions,
          event.startDate,
          event.endDate,
        );

        final pdf = pw.Document();
        final font = await PdfGoogleFonts.notoSansRegular();
        final boldFont = await PdfGoogleFonts.notoSansBold();
        final summary = _buildSummary(transactions);
        final tip = _tipOfTheDay();
        final dateFormat = DateFormat('yyyy-MM-dd');

        pdf.addPage(
          pw.MultiPage(
            pageFormat: PdfPageFormat.a4,
            build: (context) => [
              pw.Header(
                level: 0,
                child: pw.Text(
                  'FinTrack: Kіrіs-Shygys Esebі',
                  style: pw.TextStyle(font: boldFont, fontSize: 22),
                ),
              ),
              pw.Text(
                'Esap jasalgan kuni: ${dateFormat.format(DateTime.now())}',
                style: pw.TextStyle(font: font, fontSize: 11),
              ),
              pw.SizedBox(height: 14),
              pw.Text(
                '1) Qarzhylyq Sauattylyq: "Altyn Erezheler"',
                style: pw.TextStyle(font: boldFont, fontSize: 14),
              ),
              pw.SizedBox(height: 6),
              pw.Bullet(
                text: '50/30/20 erezhesi: 50% qazhettilik, 30% qalaular, 20% jinaq nemese qaryzdy zhabu.',
                style: pw.TextStyle(font: font, fontSize: 11),
              ),
              pw.Bullet(
                text: '10% erezhesi: tabys tүskende aldy-men 10%-yn bolashaqtagy oziñizge audaryñyz.',
                style: pw.TextStyle(font: font, fontSize: 11),
              ),
              pw.Bullet(
                text: '72 sagat erezhesi: emociyamen satyp aludan buryn 3 kүn kүtiñiz.',
                style: pw.TextStyle(font: font, fontSize: 11),
              ),
              pw.SizedBox(height: 14),
              pw.Text(
                '2) "Kіrіs-Shygys" Reporty',
                style: pw.TextStyle(font: boldFont, fontSize: 14),
              ),
              pw.SizedBox(height: 6),
              pw.Text(
                summary.overview,
                style: pw.TextStyle(font: font, fontSize: 11),
              ),
              pw.SizedBox(height: 4),
              pw.Text(
                'AI Keñesi: ${summary.prediction}',
                style: pw.TextStyle(font: font, fontSize: 11),
              ),
              pw.SizedBox(height: 8),
              pw.Text(
                'Top-5 Shygyn Kategoriyalary:',
                style: pw.TextStyle(font: boldFont, fontSize: 12),
              ),
              pw.SizedBox(height: 4),
              ...summary.topExpenseLines.map(
                (line) => pw.Bullet(text: line, style: pw.TextStyle(font: font, fontSize: 11)),
              ),
              pw.SizedBox(height: 12),
              pw.TableHelper.fromTextArray(
                context: context,
                border: pw.TableBorder.all(),
                headerStyle: pw.TextStyle(font: boldFont),
                cellStyle: pw.TextStyle(font: font),
                data: <List<String>>[
                  <String>['Kuni', 'Atauy', 'Kategoriya', 'Turi', 'Somasy'],
                  ...transactions.map((tx) => [
                    dateFormat.format(tx.date),
                    tx.title,
                    tx.categoryId,
                    tx.type.name,
                    CurrencyFormatter.format(tx.amount),
                  ]),
                ],
              ),
              pw.SizedBox(height: 14),
              pw.Text(
                '3) Tip of the Day',
                style: pw.TextStyle(font: boldFont, fontSize: 14),
              ),
              pw.SizedBox(height: 6),
              pw.Container(
                padding: const pw.EdgeInsets.all(10),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.grey400),
                  borderRadius: pw.BorderRadius.circular(6),
                ),
                child: pw.Text(
                  tip,
                  style: pw.TextStyle(font: font, fontSize: 11),
                ),
              ),
            ],
          ),
        );

        final bytes = await pdf.save();
        final filename = 'fintrack_report_${DateFormat('yyyyMMdd_HHmm').format(DateTime.now())}.pdf';
        await Printing.sharePdf(bytes: bytes, filename: filename);

        emit(ExportSuccess(filename));
      } catch (e) {
        emit(ExportError('Export qatesi: $e'));
      }
    });
  }

  List<TransactionEntity> _filterTransactions(
    List<TransactionEntity> items,
    DateTime? startDate,
    DateTime? endDate,
  ) {
    if (startDate == null && endDate == null) return items;
    return items.where((tx) {
      final afterStart = startDate == null || !tx.date.isBefore(startDate);
      final beforeEnd = endDate == null || !tx.date.isAfter(endDate);
      return afterStart && beforeEnd;
    }).toList();
  }

  _ReportSummary _buildSummary(List<TransactionEntity> transactions) {
    final income = transactions
        .where((t) => t.type == TransactionType.income)
        .fold<double>(0, (sum, t) => sum + t.amount);
    final expense = transactions
        .where((t) => t.type == TransactionType.expense)
        .fold<double>(0, (sum, t) => sum + t.amount);
    final balance = income - expense;
    final zone = balance >= 0 ? 'Zhasyl Aimaq (Profitsit)' : 'Qyzyl Aimaq (Defitsit)';
    final balancePercent = income == 0 ? 0 : ((balance / income) * 100).round();

    final expenseByCategory = <String, double>{};
    for (final tx in transactions.where((t) => t.type == TransactionType.expense)) {
      expenseByCategory.update(tx.categoryId, (v) => v + tx.amount, ifAbsent: () => tx.amount);
    }
    final top = expenseByCategory.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final topFive = top.take(5).toList();

    final iconMap = <String, String>{
      'food': 'Food',
      'transport': 'Transport',
      'groceries': 'Groceries',
      'rent': 'Rent',
      'medicine': 'Medicine',
      'gifts': 'Gifts',
      'entertainment': 'Entertainment',
    };

    final topExpenseLines = topFive.isEmpty
        ? <String>['Shygyn derekteri az.']
        : topFive
            .map((e) => '${iconMap[e.key] ?? e.key}: ${CurrencyFormatter.format(e.value)}')
            .toList();

    final prediction = balance >= 0
        ? 'Os yqynmen zhumsasanyz, kelesi aida jinaq shamamen ${balancePercent.clamp(5, 25)}%-ga artuy mumkin.'
        : 'Shygyn kategoriyalaryn qysqartsanyz, kelesi aida balansdy onga shygaru mumkin.';

    final overview =
        'Zhalpy sholu: tabys ${CurrencyFormatter.format(income)}, shygys ${CurrencyFormatter.format(expense)}. Status: $zone.';

    return _ReportSummary(
      overview: overview,
      prediction: prediction,
      topExpenseLines: topExpenseLines,
    );
  }

  String _tipOfTheDay() {
    const tips = <String>[
      'Chekterdi suretke tüsirip, birden bazağa engiziniz.',
      'Shygyn kategoriya köp bolsa, 5-7 negizgi topqa biriktiriniz.',
      'Zero-based budgeting: arbir teñgenin ornyn aldyn ala belgileñiz.',
    ];
    final index = DateTime.now().day % tips.length;
    return tips[index];
  }
}

class _ReportSummary {
  final String overview;
  final String prediction;
  final List<String> topExpenseLines;

  _ReportSummary({
    required this.overview,
    required this.prediction,
    required this.topExpenseLines,
  });
}

