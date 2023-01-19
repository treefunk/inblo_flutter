import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:inblo_app/constants/app_constants.dart';
import 'package:inblo_app/features/auth/api/boolean_response.dart';
import 'package:inblo_app/features/tab_treatments/api/get_treatment_response.dart';
import 'package:inblo_app/features/tab_treatments/api/treatment_list_response.dart';
import 'package:inblo_app/models/attached_file.dart';
import 'package:inblo_app/models/horse.dart';
import 'package:inblo_app/models/treatment.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';

class Treatments with ChangeNotifier {
  Treatments(this.selectedHorse);
  final Horse? selectedHorse;

  List<Treatment> _treatments = [];

  void setTreatments(List<Treatment> treatments) {
    _treatments = treatments;
  }

  List<Treatment> get treatments {
    return [..._treatments];
  }

  Future<void> fetchTreatments() async {
    if (selectedHorse == null) {
      print(selectedHorse);
      return;
    }

    final url = Uri.parse(
        "${AppConstants.apiUrl}/horses/${selectedHorse!.id}/treatments");

    final response = await http.get(url);

    print("fetching treatments...");
    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    TreatmentListResponse treatmentListResponse =
        TreatmentListResponse.fromJson(jsonResponse);

    if (treatmentListResponse.metaResponse.code == 200) {
      _treatments = treatmentListResponse.data ?? [];
    }
  }

  Future<GetTreatmentResponse> addTreatment({
    required int horseId,
    required String date,
    required String vetName,
    required String treatmentDetail,
    required String injuredPart,
    required String occasionType,
    required String medicineName,
    required String memo,
    required List<String> treatmentAttachedIds,
    required List<AttachedFile> uploadedFiles,
    required int? id,
  }) async {
    var urlStr = "${AppConstants.apiUrl}/treatment";

    if (id != null) {
      urlStr += "/$id";
    }

    print(urlStr);

    final url = Uri.parse(urlStr);

    Map<String, dynamic> treatmentData = {
      'horse_id': horseId.toString(),
      'date': date.toString(),
      'injured_part': injuredPart.toString(),
      'treatment_detail': treatmentDetail.toString(),
      'occasion_type': occasionType.toString(),
      'doctor_name': vetName.toString(),
      'medicine_name': medicineName.toString(),
      'memo': memo.toString()
    };

    if (treatmentAttachedIds.isNotEmpty) {
      treatmentData['attached_file_ids'] = treatmentAttachedIds;
    }

    var encodedInput = json.encode(treatmentData);

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
    GetTreatmentResponse result = GetTreatmentResponse.fromJson(jsonResponse);
    print(json.encode(result.metaResponse));

    if (result.metaResponse.code == 201 || result.metaResponse.code == 200) {
      if (result.data != null) {
        for (AttachedFile file in uploadedFiles) {
          await uploadFilesToTreatment(result.data!.id!, file);
        }
      }
      await fetchTreatments();
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

  Future<void> uploadFilesToTreatment(int id, AttachedFile attachedFile) async {
    var urlStr = "${AppConstants.apiUrl}/treatments/attachfile/$id";
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

  Future<BooleanResponse> removeTreatment(int treatmentId) async {
    var urlStr = "${AppConstants.apiUrl}/treatment/$treatmentId";
    var response = await http.delete(Uri.parse(urlStr));

    var decodedResponse = json.decode(response.body);

    print(decodedResponse);
    BooleanResponse result = BooleanResponse.fromJson(decodedResponse);

    if (result.metaResponse.code == 201) {
      await fetchTreatments();
      notifyListeners();
    }

    return result;
  }
}
