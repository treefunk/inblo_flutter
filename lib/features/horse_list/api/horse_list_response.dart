import 'package:inblo_app/models/horse.dart';
import 'package:inblo_app/models/meta_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'horse_list_response.g.dart';

@JsonSerializable()
class HorseListResponse {
  @JsonKey(name: "data")
  List<Horse>? data;
  @JsonKey(name: "meta")
  final MetaResponse metaResponse;

  HorseListResponse({this.data, required this.metaResponse});

  factory HorseListResponse.fromJson(Map<String, dynamic> json) =>
      _$HorseListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HorseListResponseToJson(this);
}
