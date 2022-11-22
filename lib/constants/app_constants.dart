import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  static String apiUrl = dotenv.env["API_URL"] ?? "";
  static TextInputFormatter filterDecimal =
      FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+.?[0-9]*'));
}
