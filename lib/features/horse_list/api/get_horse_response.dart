import 'package:inblo_app/models/horse.dart';
import 'package:inblo_app/models/meta_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_horse_response.g.dart';

@JsonSerializable()
class GetHorseResponse {
  @JsonKey(name: "data")
  Horse? data;
  @JsonKey(name: "meta")
  final MetaResponse metaResponse;

  GetHorseResponse({this.data, required this.metaResponse});

  factory GetHorseResponse.fromJson(Map<String, dynamic> json) =>
      _$GetHorseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetHorseResponseToJson(this);
}
