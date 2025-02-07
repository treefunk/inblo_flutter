import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:inblo_app/constants/app_constants.dart';
import 'package:inblo_app/features/auth/api/boolean_response.dart';
import 'package:inblo_app/features/tab_daily_reports/api/daily_report_form_response.dart';
import 'package:inblo_app/features/tab_daily_reports/api/daily_report_list_response.dart';
import 'package:inblo_app/features/tab_daily_reports/api/get_daily_report_response.dart';
import 'package:inblo_app/models/attached_file.dart';
import 'package:inblo_app/models/daily_report.dart';
import 'package:http/http.dart' as http;
import 'package:inblo_app/models/dropdown_data.dart';
import 'package:inblo_app/models/horse.dart';
import 'package:inblo_app/models/user_details.dart';
import 'package:inblo_app/util/preference_utils.dart';
import 'package:mime/mime.dart';

// import 'dart:html' as

class DailyReports with ChangeNotifier {
  DailyReports(this.selectedHorse);

  final Horse? selectedHorse;

  List<DailyReport> _dailyReports = [
    //
  ];

  void setDailyReports(List<DailyReport> dailyReports) {
    _dailyReports = dailyReports;
  }

  List<DailyReport> get dailyReports {
    return [..._dailyReports];
  }

  List<String> hiddenColumns = [];

  List<DropdownData> _riderOptions = [];

  List<DropdownData> get riderOptions {
    return [..._riderOptions];
  }

  List<DropdownData> _trainingTypeOptions = [];

  List<DropdownData> get trainingTypeOptions {
    return [..._trainingTypeOptions];
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
      hiddenColumns = dailyReportListResponse.hiddenColumns.split(',');
      notifyListeners();
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
    required List<String> dailyAttachedIds,
    required List<AttachedFile> uploadedFiles,
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

    if (dailyAttachedIds.isNotEmpty) {
      dailyReportData['attached_file_ids'] = dailyAttachedIds;
    }

    if (riderId != null) {
      dailyReportData["rider_id"] = riderId.toString();
    }

    if (trainingTypeId != null) {
      dailyReportData["training_type_id"] = trainingTypeId.toString();
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
      if (result.data != null) {
        for (AttachedFile file in uploadedFiles) {
          await uploadFilesToDailyReport(result.data!.id!, file);
        }
      }
      await fetchDailyReports();
      notifyListeners();
    }

    return result;
  }

  Future<http.MultipartFile> getMultipartByPlatform(AttachedFile file) async {
    // print("file type is ${xFile.mimeType}");
    // print("path -> " +xFile.path.toString() + xFile.name);

    if (!kIsWeb) {
      var f = File(file.filePath!);

      var mimeType = lookupMimeType(f.path)!.split("/");
      return await http.MultipartFile.fromPath(
        'file',
        file.filePath!,
        contentType: MediaType(mimeType[0], mimeType[1]),
      );
    } else {
      var mimeType = lookupMimeType(file.name!)!.split("/");
      print(file.toJson());
      return http.MultipartFile.fromBytes(
        'file',
        file.webFile!,
        filename: file.filePath,
        contentType: MediaType(mimeType[0], mimeType[1]),
      );
    }
  }

  Future<void> uploadFilesToDailyReport(
      int id, AttachedFile attachedFile) async {
    var urlStr = "${AppConstants.apiUrl}/daily_reports/attachfile/$id";
    final url = Uri.parse(urlStr);

    var multipartFuture = await getMultipartByPlatform(attachedFile);

    var headers = {
      "Accept": "application/json",
      "Content-Type": "application/json"
    };

    var request = http.MultipartRequest("POST", url)
      ..files.add(await getMultipartByPlatform(attachedFile));

    var response = await request.send();

    print(response.stream.bytesToString());

    //
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
