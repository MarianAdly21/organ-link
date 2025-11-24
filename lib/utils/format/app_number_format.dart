import 'package:intl/intl.dart';

class AppNumberFormat {
  static final NumberFormat numberFormat = NumberFormat("#,##0.00");

  static String formatAmount(num amount, {bool addNegative = false}) {
    // Format the amount with two decimal places
    amount = addNegative ? -amount : amount;
    String formatted = numberFormat.format(amount);
    // Remove trailing .00 for whole numbers
    formatted = formatted.replaceAll(RegExp(r'(\.00$)'), '');
    return formatted;
  }

  static String percentageSeparator(num number, num totalValue) {
    final double percent = (number / totalValue);
    return NumberFormat.decimalPercentPattern(decimalDigits: 1).format(percent);
  }
}
