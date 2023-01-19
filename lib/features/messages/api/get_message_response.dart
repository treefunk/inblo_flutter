import 'package:inblo_app/models/message.dart';
import 'package:inblo_app/models/meta_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_message_response.g.dart';

@JsonSerializable()
class GetMessageResponse {
  @JsonKey(name: "data")
  Message? data;
  @JsonKey(name: "meta")
  final MetaResponse metaResponse;

  GetMessageResponse({this.data, required this.metaResponse});

  factory GetMessageResponse.fromJson(Map<String, dynamic> json) =>
      _$GetMessageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetMessageResponseToJson(this);
}
