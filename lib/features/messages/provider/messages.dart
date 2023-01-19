import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:inblo_app/constants/app_constants.dart';
import 'package:inblo_app/features/auth/api/boolean_response.dart';
import 'package:inblo_app/features/messages/api/get_message_response.dart';
import 'package:inblo_app/features/messages/api/message_list_response.dart';
import 'package:inblo_app/models/message.dart';
import 'package:inblo_app/models/user_details.dart';
import 'package:inblo_app/util/preference_utils.dart';
import 'package:http/http.dart' as http;

class Messages with ChangeNotifier {
  Messages();

  List<Message> _messages = [
    //
  ];

  List<Message> get messages {
    return [..._messages];
  }

  Future<void> fetchMessages() async {
    UserDetails userDetails = await PreferenceUtils.getUserDetails();

    final url =
        Uri.parse("${AppConstants.apiUrl}/user/${userDetails.userId}/messages");

    final response = await http.get(url);
    var jsonResponse = json.decode(response.body);

    print("fetching messages.");
    print(jsonResponse);

    MessageListResponse messageListResponse =
        MessageListResponse.fromJson(jsonResponse);

    if (messageListResponse.metaResponse.code == 200) {
      _messages = messageListResponse.data ?? [];
      notifyListeners();
    }
  }

  Future<GetMessageResponse> addMessage({
    required int? recipientId,
    required int? horseId,
    required String horseName,
    required String notificationType,
    required String title,
    required String memo,
    required String isRead,
    required int? id,
  }) async {
    UserDetails userDetails = await PreferenceUtils.getUserDetails();

    var urlStr = "${AppConstants.apiUrl}/messages";

    if (id != null) {
      urlStr += "/$id";
    }

    final url = Uri.parse(urlStr);
    final Map<String, dynamic> messageData = {
      'stable_id': userDetails.stableId.toString(),
      'sender_id': userDetails.userId.toString(),
      'horse_name': horseName.toString(),
      'notification_type': notificationType.toString(),
      'title': title.toString(),
      'memo': memo.toString(),
      'is_read': isRead.toString()
    };

    if (horseId != null) {
      messageData["horse_id"] = horseId.toString();
    }

    if (recipientId != 0) {
      messageData['recipient_id'] = recipientId.toString();
    }

    var encodedInput = json.encode(messageData);

    print(encodedInput);

    http.Response response;
    if (id == null) {
      // if no id is given, add horse
      response = await http.post(
        url,
        body: encodedInput,
        headers: {"Content-Type": "application/json"},
      );
      print("creating message..");
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
      print("updating existing message");
    }

    var jsonResponse = json.decode(response.body);

    print(jsonResponse);

    GetMessageResponse getMessageResponse =
        GetMessageResponse.fromJson(jsonResponse);

    if (getMessageResponse.metaResponse.code == 201) {
      await fetchMessages();
      notifyListeners();
    }

    return getMessageResponse;
  }

  Future<BooleanResponse> removeMessage(int messageId) async {
    var urlStr = "${AppConstants.apiUrl}/messages/$messageId";
    var response = await http.delete(Uri.parse(urlStr));

    var decodedResponse = json.decode(response.body);

    print(decodedResponse);
    BooleanResponse result = BooleanResponse.fromJson(decodedResponse);

    if (result.metaResponse.code == 201) {
      await fetchMessages();
      notifyListeners();
    }

    return result;
  }
}
