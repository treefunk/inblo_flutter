import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:inblo_app/constants/app_constants.dart';
import 'package:inblo_app/features/tab_daily_reports/api/daily_report_form_response.dart';
import 'package:inblo_app/features/tab_daily_reports/api/daily_report_list_response.dart';
import 'package:inblo_app/features/tab_daily_reports/api/get_daily_report_response.dart';
import 'package:inblo_app/models/daily_report.dart';
import 'package:http/http.dart' as http;
import 'package:inblo_app/models/dropdown_data.dart';
import 'package:inblo_app/models/horse.dart';
import 'package:inblo_app/models/user_details.dart';
import 'package:inblo_app/util/preference_utils.dart';

class DailyReports with ChangeNotifier {
  List<DropdownData> _riderOptions = [];
  List<DropdownData> _trainingTypeOptions = [];

  List<DropdownData> get riderOptions {
    return [...riderOptions];
  }

  List<DropdownData> get trainingTypeOptions {
    return [...trainingTypeOptions];
  }

  DailyReports(this.selectedHorse);

  final Horse? selectedHorse;

  List<DailyReport> _dailyReports = [
    //
  ];

  List<DailyReport> get dailyReports {
    return [..._dailyReports];
  }

  Future<void> fetchDailyReports() async {
    if (selectedHorse == null) {
      return;
    }

    final url = Uri.parse(
        "${AppConstants.apiUrl}/horses/${selectedHorse!.id}/daily-reports");

    final response = await http.get(url);

    //fetching daily reports
    print("fetching daily reports");
    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    DailyReportListResponse dailyReportListResponse =
        DailyReportListResponse.fromJson(jsonResponse);

    if (dailyReportListResponse.metaResponse.code == 200) {
      _dailyReports = dailyReportListResponse.data ?? [];
    }
  }

  Future<GetDailyReportResponse> addDailyReport(
      int horseId,
      String date,
      double bodyTemperature,
      int horseWeight,
      String conditionGroup,
      String riderName, // not needed
      String trainingTypeName, // not needed
      int? riderId,
      int? trainingTypeId,
      String trainingAmount,
      double time5f,
      double time4f,
      double time3f,
      String memo,
      List<String>? dailyAttachedIds,
      int? id) async {
    var urlStr = "${AppConstants.apiUrl}/daily-reports";

    if (id != null) {
      urlStr += "/$id";
    }

    final url = Uri.parse(urlStr);

    Map<String, dynamic> dailyReportData = {
      'horse_id': horseId,
      'date': date,
      'body_temperature': bodyTemperature,
      'horse_weight': horseWeight,
      'condition_group': conditionGroup,
      'rider_name': riderName,
      'training_type_name': trainingTypeName,
      'training_amount': trainingAmount,
      '5f_time': time5f,
      '4f_time': time4f,
      '3f_time': time3f,
      'memo': memo
    };

    if (riderId != null) {
      dailyReportData["rider_id"] = riderId;
    }

    if (trainingTypeId != null) {
      dailyReportData["training_type_id"] = trainingTypeId;
    }

    if (dailyAttachedIds != null) {
      for (var id in dailyAttachedIds) {
        dailyReportData["attached_file_ids[]"] = id;
      }
    }

    var encodedInput = json.encode(dailyReportData);

    var response = await http.post(url, body: encodedInput, headers: {
      "Accept": "application/json",
      "Content-Type": "application/json"
    });

    var jsonResponse = json.decode(response.body);

    print(jsonResponse);

    GetDailyReportResponse result =
        GetDailyReportResponse.fromJson(jsonResponse);

    return result;
  }

  // populate rider and training type dropdown data
  Future<void> initDailyReportDropdown() async {
    UserDetails userDetails = await PreferenceUtils.getUserDetails();

    var url = Uri.parse(
        "${AppConstants.apiUrl}/daily_reports/get-form/${userDetails.stableId}");

    final response = await http.get(url);

    var jsonResponse = json.decode(response.body);

    print(jsonResponse);

    var result = DailyReportFormResponse.fromJson(jsonResponse);

    _riderOptions = result.data?.riders ?? [];
    _trainingTypeOptions = result.data?.trainingTypes ?? [];

    notifyListeners();
  }
}
