import 'package:fintrack/core/utils/currency_formatter.dart';
import 'package:fintrack/domain/repositories/transaction_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        // 1. Деректерді алу
        final transactions = await repository.getAllTransactions();
        
        // 2. PDF құжатын бастау
        final pdf = pw.Document();
        final font = await PdfGoogleFonts.robotoRegular(); // Қазақ тілі/Кириллица үшін

        pdf.addPage(
          pw.MultiPage(
            pageFormat: PdfPageFormat.a4,
            build: (context) => [
              pw.Header(level: 0, child: pw.Text("FinTrack: Tranzakciya esebі", style: pw.TextStyle(font: font, fontSize: 24))),
              pw.SizedBox(height: 20),
              
              // Транзакциялар кестесі
              pw.TableHelper.fromTextArray(
                context: context,
                border: pw.TableBorder.all(),
                headerStyle: pw.TextStyle(font: font, fontWeight: pw.FontWeight.bold),
                cellStyle: pw.TextStyle(font: font),
                data: <List<String>>[
                  <String>['Data', 'Aty', 'Sanaty', 'Turi', 'Somasy'],
                  ...transactions.map((tx) => [
                    tx.date.toString().substring(0, 10),
                    tx.title,
                    tx.categoryId,
                    tx.type.name,
                    CurrencyFormatter.format(tx.amount),
                  ]),
                ],
              ),
            ],
          ),
        );

        // 3. Файлды көрсету немесе сақтау
        await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
        
        emit(ExportSuccess("PDF satti jasaldy"));
      } catch (e) {
        emit(ExportError("Export qatesі: $e"));
      }
    });
  }
}
