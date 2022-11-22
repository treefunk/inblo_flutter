import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';
import 'package:inblo_app/constants/app_constants.dart';
import 'package:inblo_app/features/horse_list/api/get_horse_response.dart';
import 'package:inblo_app/features/horse_list/api/horse_list_response.dart';
import 'package:inblo_app/models/horse.dart';
import 'package:inblo_app/models/user_details.dart';
import 'package:inblo_app/util/preference_utils.dart';

class Horses with ChangeNotifier {
  List<Horse> _horses = [
    //
  ];

  List<Horse> get horses {
    return [..._horses];
  }

  Future<void> fetchHorses() async {
    UserDetails userDetails = await PreferenceUtils.getUserDetails();

    final url = Uri.parse(
        "${AppConstants.apiUrl}/horses/stable/${userDetails.stableId}");

    final response = await http.get(url);

    var jsonResponse = json.decode(response.body);
    print("fetching horses...");
    print(jsonResponse);
    var result = HorseListResponse.fromJson(jsonResponse);
    _horses = result.data ?? [];

    notifyListeners();
  }

  Future<void> addHorse({
    required String name,
    required int userId,
    String ownerName = "",
    String farmName = "",
    String trainingFarmName = "",
    required String sex,
    required String color,
    String horseClass = "",
    String? birthDate,
    String father = "",
    String mother = "",
    String motherFatherName = "",
    double totalStake = 0.0,
    String memo = "",
    int? horseId,
  }) async {
    UserDetails userDetails = await PreferenceUtils.getUserDetails();

    final url = Uri.parse("${AppConstants.apiUrl}/horses");
    // birth_date, user_id
    final horseData = {
      'name': name,
      'sex': sex,
      'color': color,
      'class': horseClass,
      'father_name': father,
      'mother_name': mother,
      'mother_father_name': motherFatherName,
      'total_stake': totalStake.toString(),
      'owner_name': ownerName,
      'farm_name': farmName,
      'training_farm_name': motherFatherName,
      'memo': memo,
      'stable_id': userDetails.stableId.toString(),
    };

    if (birthDate != null && birthDate.isNotEmpty) {
      horseData["birth_date"] = birthDate;
    }

    if (userId > 0) {
      horseData["user_id"] = userId.toString();
    }

    var encodedInput = json.encode(horseData);
    print(encodedInput);

    final response = await http.post(
      url,
      body: encodedInput,
      headers: {"Content-Type": "application/json"},
    );

    var jsonResponse = json.decode(response.body);
    print("creating horse..");
    print(jsonResponse);
    var result = GetHorseResponse.fromJson(jsonResponse);

    notifyListeners();
  }
}
