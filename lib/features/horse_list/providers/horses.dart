import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';
import 'package:inblo_app/constants/app_constants.dart';
import 'package:inblo_app/features/auth/api/boolean_response.dart';
import 'package:inblo_app/features/horse_list/api/get_horse_response.dart';
import 'package:inblo_app/features/horse_list/api/horse_list_response.dart';
import 'package:inblo_app/features/tab_daily_reports/providers/daily_reports.dart';
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

  List<Horse> _archivedHorses = [
    //
  ];

  List<Horse> get archivedHorses {
    return [..._archivedHorses];
  }

  late Horse selectedHorse;

  void setSelectedHorseByIndex(int index) {
    selectedHorse = _horses[index];
    notifyListeners();
  }

  Future<void> fetchHorses() async {
    UserDetails userDetails = await PreferenceUtils.getUserDetails();

    final url = Uri.parse(
        "${AppConstants.apiUrl}/horses/stable/${userDetails.stableId}");

    final response = await http.get(url);

    var jsonResponse = json.decode(response.body);
    print("fetching horses...");
    // print(jsonResponse);
    var result = HorseListResponse.fromJson(jsonResponse);
    _horses = result.data ?? [];

    notifyListeners();
  }

  Future<void> fetchArchivedHorses() async {
    UserDetails userDetails = await PreferenceUtils.getUserDetails();

    final url = Uri.parse(
        "${AppConstants.apiUrl}/horses/stable/${userDetails.stableId}?archived=1");

    final response = await http.get(url);

    var jsonResponse = json.decode(response.body);
    print("fetching archived horses...");
    // print(jsonResponse);
    var result = HorseListResponse.fromJson(jsonResponse);
    _archivedHorses = result.data ?? [];

    notifyListeners();
  }

  Future<GetHorseResponse> addHorse({
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

    var urlStr = "${AppConstants.apiUrl}/horses";

    if (horseId != null) {
      urlStr += "/$horseId";
    }

    final url = Uri.parse(urlStr);
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
      'training_farm_name': trainingFarmName,
      'memo': memo,
      'stable_id': userDetails.stableId.toString(),
    };

    if (birthDate != null && birthDate.isNotEmpty) {
      horseData["birth_date"] = birthDate;
    }

    if (userId > 0) {
      horseData["user_id"] = userId.toString();
    } else {
      horseData["user_id"] = "-1"; // remove user
    }

    var encodedInput = json.encode(horseData);
    // print(encodedInput);
    http.Response response;

    print("url: $url");

    if (horseId == null) {
      // if no id is given, add horse
      response = await http.post(
        url,
        body: encodedInput,
        headers: {"Content-Type": "application/json"},
      );
      print("creating horse..");
    } else {
      // update horse
      response = await http.put(
        url,
        body: encodedInput,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
      );
      print("updating existing horse");
    }

    var jsonResponse = json.decode(response.body);
    // var test = jsonResponse(GetHorseResponse);
    // print("test: ${test.metaResponse.message}");
    print("-------jsonstart---------");
    print(jsonResponse);
    print("-------jsonend---------");

    // jsonResponse = json.encode((jsonResponse));

    var result = GetHorseResponse.fromJson(jsonResponse);

    if (horseId != null) {
      selectedHorse = result.data!;
      DailyReports(selectedHorse).notifyListeners();
      notifyListeners();
    }

    if (result.metaResponse.code == 201) {
      await fetchHorses();
    }

    return result;

    // notifyListeners();
  }

  Future<BooleanResponse> archiveHorse(int horseId) async {
    final url = Uri.parse("${AppConstants.apiUrl}/horses/archive/$horseId");

    final response = await http.get(url);

    var jsonResponse = json.decode(response.body);
    print("archiving horse...");
    // print(jsonResponse);
    var result = BooleanResponse.fromJson(jsonResponse);
    fetchHorses();
    return result;
  }

  Future<BooleanResponse> restoreArchivedHorse(int horseId) async {
    final url = Uri.parse("${AppConstants.apiUrl}/horses/restore/$horseId");

    final response = await http.get(url);

    var jsonResponse = json.decode(response.body);
    print("restoring horse...");
    // print(jsonResponse);
    var result = BooleanResponse.fromJson(jsonResponse);

    fetchArchivedHorses();

    return result;
  }

  Horse getHorseById(int id) {
    return horses.firstWhere((element) => element.id == id);
  }
}
