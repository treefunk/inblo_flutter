import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:inblo_app/constants/app_constants.dart';
import 'package:inblo_app/models/user.dart';
import 'package:inblo_app/models/user_details.dart';
import 'package:inblo_app/util/preference_utils.dart';
import 'package:json_annotation/json_annotation.dart';

import '../api/login_response.dart';

class Auth with ChangeNotifier {
  Auth();

  UserDetails? _userDetails; // logged in user

  UserDetails? get userDetails {
    if (_userDetails != null) {
      return UserDetails(
        userId: _userDetails!.userId,
        username: _userDetails!.username,
        stableId: _userDetails!.stableId,
        roleId: _userDetails!.roleId,
      );
    }
    return null;
  }

  void setUserDetails(UserDetails userDetails) async {
    var isDetailsSet = await PreferenceUtils.setUserDetails(
      UserDetails(
        userId: userDetails.userId,
        username: userDetails.username,
        stableId: userDetails.stableId,
        roleId: userDetails.roleId,
      ),
    );

    if (isDetailsSet) {
      _userDetails = userDetails;
    }

    notifyListeners();
  }

  Future<LoginResponse> registerUser(
    String username,
    String password,
    String firstName,
    String lastName,
    String email,
    int roleId,
    String stableCode,
  ) async {
    final url = Uri.parse("${AppConstants.apiUrl}/register");

    final encodedInput = json.encode({
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'username': username,
      'password': password,
      'stable_code': stableCode,
      'user_type': roleId,
    });

    final response = await http.post(url,
        body: encodedInput, headers: {"Content-Type": "application/json"});

    var jsonResponse = json.decode(response.body);
    print(jsonResponse);
    var result = LoginResponse.fromJson(jsonResponse);

    return result;
  }

  Future<LoginResponse> loginUser(String username, String password) async {
    final url = Uri.parse("${AppConstants.apiUrl}/login");

    final response = await http
        .post(url, body: {'username': username, 'password': password});

    var jsonResponse = json.decode(response.body);
    var result = LoginResponse.fromJson(jsonResponse);

    if (result.metaResponse.code == 200) {
      User? user = result.data;
      if (user != null) {
        var userDetails = UserDetails(
          userId: user.id!,
          username: user.username!,
          stableId: user.stable!.id!,
          roleId: user.roleId!,
        ); // shared preference
        setUserDetails(userDetails); // provider
      }
    }
    notifyListeners();
    return result;
  }

  Future<bool> tryAutoLogin() async {
    int? userId = await PreferenceUtils.getUserId();

    if (userId == null) return false;

    UserDetails userDetails = await PreferenceUtils.getUserDetails();
    _userDetails = userDetails;

    print("autologging");

    notifyListeners();

    return true;
  }

  Future<bool> logout() async {
    PreferenceUtils.clearPreferences();
    _userDetails = null;
    notifyListeners();
    return true;
  }
}
