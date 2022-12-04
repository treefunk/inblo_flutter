import 'package:inblo_app/models/daily_report.dart';
import 'package:inblo_app/models/meta_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'daily_report_list_response.g.dart';

@JsonSerializable()
class DailyReportListResponse {
  @JsonKey(name: "data")
  List<DailyReport>? data;
  @JsonKey(name: "meta")
  final MetaResponse metaResponse;
  @JsonKey(name: "hidden_columns")
  final String hiddenColumns;

  DailyReportListResponse(
      {this.data, required this.metaResponse, required this.hiddenColumns});

  factory DailyReportListResponse.fromJson(Map<String, dynamic> json) =>
      _$DailyReportListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DailyReportListResponseToJson(this);
}
