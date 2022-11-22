import 'package:inblo_app/models/dropdown_data.dart';
import 'package:json_annotation/json_annotation.dart';
import 'meta_response.dart';

part 'dropdown_data_response.g.dart';

@JsonSerializable()
class DropdownDataResponse {
  @JsonKey(name: "data")
  final List<DropdownData>? data;
  @JsonKey(name: "meta")
  final MetaResponse metaResponse;

  DropdownDataResponse({this.data, required this.metaResponse});

  factory DropdownDataResponse.fromJson(Map<String, dynamic> json) =>
      _$DropdownDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DropdownDataResponseToJson(this);
}
