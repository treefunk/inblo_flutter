import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  static final String apiUrl = dotenv.env["API_URL"] ?? "";
  static final TextInputFormatter filterDecimal =
      FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+.?[0-9]*'));
  static final GlobalKey<ScaffoldState> mainDashboardScaffoldKey =
      GlobalKey<ScaffoldState>();

  static final wholeNumberRegX = RegExp(r'^\d+$');

  static final wholeAndDecimalRegX = RegExp(r'^\d*(\.\d+)?$');

  static const dateOnlyFormatYmd = "y-MM-dd";

  static String? requireCallback(value) {
    if (value == null) {
      return "This field is required";
    }
    return null;
  }
}
