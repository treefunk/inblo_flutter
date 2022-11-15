import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  static String apiUrl = dotenv.env["API_URL"] ?? "";
}
