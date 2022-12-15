import 'package:inblo_app/models/treatment.dart';
import 'package:inblo_app/models/meta_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_treatment_response.g.dart';

@JsonSerializable()
class GetTreatmentResponse {
  @JsonKey(name: "data")
  Treatment? data;
  @JsonKey(name: "meta")
  final MetaResponse metaResponse;

  GetTreatmentResponse({this.data, required this.metaResponse});

  factory GetTreatmentResponse.fromJson(Map<String, dynamic> json) =>
      _$GetTreatmentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetTreatmentResponseToJson(this);
}
