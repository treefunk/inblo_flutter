import 'package:inblo_app/models/treatment.dart';
import 'package:inblo_app/models/meta_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'treatment_list_response.g.dart';

@JsonSerializable()
class TreatmentListResponse {
  @JsonKey(name: "data")
  List<Treatment>? data;
  @JsonKey(name: "meta")
  final MetaResponse metaResponse;
  // @JsonKey(name: "hidden_columns")
  // final String hiddenColumns;

  TreatmentListResponse({
    this.data,
    required this.metaResponse,
    // required this.hiddenColumns,
  });

  factory TreatmentListResponse.fromJson(Map<String, dynamic> json) =>
      _$TreatmentListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TreatmentListResponseToJson(this);
}
