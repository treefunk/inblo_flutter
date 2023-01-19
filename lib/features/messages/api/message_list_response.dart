import 'package:inblo_app/models/message.dart';
import 'package:inblo_app/models/meta_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message_list_response.g.dart';

@JsonSerializable()
class MessageListResponse {
  @JsonKey(name: "data")
  List<Message>? data;
  @JsonKey(name: "meta")
  final MetaResponse metaResponse;

  MessageListResponse({this.data, required this.metaResponse});

  factory MessageListResponse.fromJson(Map<String, dynamic> json) =>
      _$MessageListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MessageListResponseToJson(this);
}
