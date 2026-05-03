import 'package:intl/intl.dart';

class CurrencyFormatter {
  static String format(double amount) {
    return NumberFormat.currency(locale: 'kk_KZ', symbol: '₸').format(amount);
  }
}