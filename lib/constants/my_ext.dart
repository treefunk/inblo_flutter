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
