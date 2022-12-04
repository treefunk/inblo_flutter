import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:inblo_app/constants/app_constants.dart';
import 'package:inblo_app/features/horse_list/api/get_users_response.dart';
import 'package:inblo_app/models/dropdown_data.dart';
import 'package:inblo_app/models/user_details.dart';
import 'package:inblo_app/util/preference_utils.dart';
import 'package:http/http.dart' as http;

class PersonsInCharge with ChangeNotifier {
  List<DropdownData> _personInChargeOptions = [];

  List<DropdownData> get personInChargeOptions {
    return [..._personInChargeOptions];
  }

  Future<void> initPersonInCharge({int? excludeId, int? stableId = -1}) async {
    UserDetails userDetails = await PreferenceUtils.getUserDetails();

    var urlString = "${AppConstants.apiUrl}/users?";

    if (stableId == -1) {
      urlString += "stable_id=${userDetails.stableId}";
    } else if (stableId != null) {
      urlString += "stable_id=$stableId";
    }

    if (excludeId != null) {
      if (stableId != null) {
        urlString += "&";
      }
      urlString += "exclude_id=$excludeId";
    }

    final url = Uri.parse(urlString);
    print("generated url: $url");

    final response = await http.get(url);

    var jsonResponse = json.decode(response.body);
    print("fetching users....");
    var result = GetUsersResponse.fromJson(jsonResponse);
    _personInChargeOptions = result.data
            ?.map((user) => DropdownData(id: user.id, name: user.username))
            .toList() ??
        [];

    notifyListeners();
  }
}
