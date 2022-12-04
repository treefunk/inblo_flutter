import 'package:inblo_app/models/daily_report.dart';
import 'package:inblo_app/models/meta_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_daily_report_response.g.dart';

@JsonSerializable()
class GetDailyReportResponse {
  @JsonKey(name: "data")
  DailyReport? data;
  @JsonKey(name: "meta")
  final MetaResponse metaResponse;

  GetDailyReportResponse({this.data, required this.metaResponse});

  factory GetDailyReportResponse.fromJson(Map<String, dynamic> json) =>
      _$GetDailyReportResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetDailyReportResponseToJson(this);
}
