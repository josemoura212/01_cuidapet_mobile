import 'package:intl/intl.dart';

class TextFormatter {
  TextFormatter._();
  static final _formartRealPattern =
      NumberFormat.currency(locale: "pt_BR", symbol: r"R$");
  static String formateReal(double value) => _formartRealPattern.format(value);
}
