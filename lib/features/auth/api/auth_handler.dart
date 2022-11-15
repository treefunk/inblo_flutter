import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:inblo_app/constants/app_constants.dart';
import 'package:inblo_app/models/meta_response.dart';
import 'package:inblo_app/models/user.dart';

import 'login_response.dart';

class AuthHandler {
  AuthHandler();

  static Future<LoginResponse> loginUser(
      String username, String password) async {
    final url = Uri.parse("${AppConstants.apiUrl}/login");

    final response = await http
        .post(url, body: {'username': username, 'password': password});

    var jsonResponse = json.decode(response.body);
    var result = LoginResponse.fromJson(jsonResponse);
    return result;
  }
}
