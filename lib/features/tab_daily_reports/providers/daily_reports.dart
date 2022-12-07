import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:inblo_app/constants/app_constants.dart';
import 'package:inblo_app/features/auth/api/boolean_response.dart';
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
    return [..._riderOptions];
  }

  List<DropdownData> get trainingTypeOptions {
    return [..._trainingTypeOptions];
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

  Future<GetDailyReportResponse> addDailyReport({
    required int horseId,
    required String date,
    required double bodyTemperature,
    required int horseWeight,
    required String conditionGroup,
    // required String riderName, // not needed
    // required String trainingTypeName, // not needed
    required int? riderId,
    required int? trainingTypeId,
    required String trainingAmount,
    required double time5f,
    required double time4f,
    required double time3f,
    required String memo,
    required List<String>? dailyAttachedIds,
    required int? id,
  }) async {
    var urlStr = "${AppConstants.apiUrl}/daily-reports";

    if (id != null) {
      urlStr += "/$id";
    }

    print(urlStr);

    final url = Uri.parse(urlStr);

    Map<String, dynamic> dailyReportData = {
      'horse_id': horseId.toString(),
      'date': date.toString(),
      'body_temperature': bodyTemperature.toString(),
      'horse_weight': horseWeight.toString(),
      'condition_group': conditionGroup.toString(),
      // 'rider_name': riderName,
      // 'training_type_name': trainingTypeName,
      'training_amount': trainingAmount.toString(),
      '5f_time': time5f.toString(),
      '4f_time': time4f.toString(),
      '3f_time': time3f.toString(),
      'memo': memo.toString()
    };

    if (riderId != null) {
      dailyReportData["rider_id"] = riderId.toString();
    }

    if (trainingTypeId != null) {
      dailyReportData["training_type_id"] = trainingTypeId.toString();
    }

    if (dailyAttachedIds != null) {
      for (var id in dailyAttachedIds) {
        dailyReportData["attached_file_ids[]"] = id;
      }
    }

    var encodedInput = json.encode(dailyReportData);

    print(encodedInput);

    var headers = {
      "Accept": "application/json",
      "Content-Type": "application/json"
    };
    dynamic response;
    if (id == null) {
      // insert
      response = await http.post(url, body: encodedInput, headers: headers);
    } else {
      response = await http.put(url, body: encodedInput, headers: headers);
    }

    var jsonResponse = json.decode(response.body);

    print(jsonResponse);

    GetDailyReportResponse result =
        GetDailyReportResponse.fromJson(jsonResponse);
    print(json.encode(result.metaResponse));

    if (result.metaResponse.code == 201 || result.metaResponse.code == 200) {
      await fetchDailyReports();
      notifyListeners();
    }

    return result;
  }

  // populate rider and training type dropdown data
  Future<void> initDailyReportDropdown() async {
    UserDetails userDetails = await PreferenceUtils.getUserDetails();

    var url = Uri.parse(
        "${AppConstants.apiUrl}/daily_reports/get-form/${userDetails.stableId}");

    print("fetching daily report form data....");
    final response = await http.get(url);

    var jsonResponse = json.decode(response.body);

    print(jsonResponse);

    var result = DailyReportFormResponse.fromJson(jsonResponse);

    _riderOptions = result.data?.riders ?? [];
    _trainingTypeOptions = result.data?.trainingTypes ?? [];

    notifyListeners();
  }

  Future<BooleanResponse> removeDailyReport(int dailyReportId) async {
    var urlStr = "${AppConstants.apiUrl}/daily-reports/$dailyReportId";
    var response = await http.delete(Uri.parse(urlStr));

    var decodedResponse = json.decode(response.body);

    print(decodedResponse);
    BooleanResponse result = BooleanResponse.fromJson(decodedResponse);

    if (result.metaResponse.code == 201) {
      await fetchDailyReports();
      notifyListeners();
    }

    return result;
  }
}
