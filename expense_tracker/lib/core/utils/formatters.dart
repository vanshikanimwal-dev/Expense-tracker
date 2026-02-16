import 'package:intl/intl.dart';

extension AppFormatters on DateTime {
  /// Converts DateTime to a readable string: "Feb 15, 2026"
  String get formatDate => DateFormat.yMMMd().format(this);

  /// Converts DateTime to a short month/year: "Feb 2026" (Useful for headers)
  String get formatMonthYear => DateFormat.yMMM().format(this);
}

extension CurrencyFormatter on double {
  /// Converts double to currency format: "$1,250.50"
  /// It automatically handles commas and the currency symbol.
  String get formatCurrency {
    return NumberFormat.currency(
      symbol: '\$',
      decimalDigits: 2,
    ).format(this);
  }
}