import 'package:intl/intl.dart';

extension StringParsing on String {
  double parseDoubleOrZero() {
    var value = this;
    if (value.isEmpty) {
      return 0.0;
    }
    return double.parse(value);
  }

  int parseIntOrZero() {
    var value = this;
    if (value.isEmpty) {
      return 0;
    }
    return int.parse(value);
  }
}

extension StringNullableParsing on String? {
  String? ifEmptyNull() {
    var value = this;
    if (value != null && value.isEmpty) {
      return null;
    }
    return value;
  }
}

extension MonthParsing on int {
  String withZeroPrefix() {
    var value = this;
    var monthPref = "";
    if (value.toString().length == 1) {
      monthPref = "0";
    }
    return monthPref + value.toString();
  }
}

extension MonthParsingString on String {
  String toDateTimeInblo() {
    var value = this;
    var monthPref = "";
    if (value.toString().length == 1) {
      monthPref = "0";
    }
    return monthPref + value.toString();
  }
}

extension DateTimeExt on DateTime {
  String format(String formatPattern) => DateFormat(formatPattern).format(this);
}
