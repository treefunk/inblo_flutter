import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:inblo_app/constants/app_constants.dart';
import 'package:inblo_app/features/horse_list/api/get_users_response.dart';
import 'package:inblo_app/models/dropdown_data.dart';
import 'package:inblo_app/models/user_details.dart';
import 'package:inblo_app/util/preference_utils.dart';
import 'package:http/http.dart' as http;

class Users with ChangeNotifier {
  List<DropdownData> _personInChargeOptions = [];

  List<DropdownData> get personInChargeOptions {
    return [..._personInChargeOptions];
  }

  List<DropdownData> _userRecipients = [];

  List<DropdownData> get userRecipients {
    return [..._userRecipients];
  }

  Future<void> fetchUsers({
    bool? excludeAuthUser,
    int? stableId = -1,
    bool forMessageRecipients = false,
  }) async {
    UserDetails userDetails = await PreferenceUtils.getUserDetails();

    var urlString = "${AppConstants.apiUrl}/users?";

    if (stableId == -1) {
      urlString += "stable_id=${userDetails.stableId}";
    } else if (stableId != null) {
      urlString += "stable_id=$stableId";
    }

    if (excludeAuthUser != null && excludeAuthUser) {
      if (stableId != null) {
        urlString += "&";
      }
      urlString += "exclude_id=${userDetails.userId}";
    }

    final url = Uri.parse(urlString);
    print("generated url: $url");

    final response = await http.get(url);

    var jsonResponse = json.decode(response.body);
    print("fetching users....");
    var result = GetUsersResponse.fromJson(jsonResponse);

    if (!forMessageRecipients) {
      _personInChargeOptions = result.data
              ?.map((user) => DropdownData(id: user.id, name: user.username))
              .toList() ??
          [];
    } else {
      _userRecipients = result.data
              ?.map((user) => DropdownData(id: user.id, name: user.username))
              .toList() ??
          [];
    }

    notifyListeners();
  }
}
