// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_daily_report_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetDailyReportResponse _$GetDailyReportResponseFromJson(
        Map<String, dynamic> json) =>
    GetDailyReportResponse(
      data: json['data'] == null
          ? null
          : DailyReport.fromJson(json['data'] as Map<String, dynamic>),
      metaResponse: MetaResponse.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetDailyReportResponseToJson(
        GetDailyReportResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.metaResponse,
    };
