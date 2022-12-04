import 'package:inblo_app/features/tab_daily_reports/api/daily_report_form.dart';
import 'package:inblo_app/models/meta_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'daily_report_form_response.g.dart';

@JsonSerializable()
class DailyReportFormResponse {
  @JsonKey(name: "data")
  DailyReportForm? data;
  @JsonKey(name: "meta")
  final MetaResponse metaResponse;

  DailyReportFormResponse({
    this.data,
    required this.metaResponse,
  });

  factory DailyReportFormResponse.fromJson(Map<String, dynamic> json) =>
      _$DailyReportFormResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DailyReportFormResponseToJson(this);
}
