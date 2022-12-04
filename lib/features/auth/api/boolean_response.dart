import 'package:inblo_app/models/meta_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'boolean_response.g.dart';

@JsonSerializable()
class BooleanResponse {
  @JsonKey(name: "data")
  final bool? data;
  @JsonKey(name: "meta")
  final MetaResponse metaResponse;

  BooleanResponse({this.data, required this.metaResponse});

  factory BooleanResponse.fromJson(Map<String, dynamic> json) =>
      _$BooleanResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BooleanResponseToJson(this);
}
