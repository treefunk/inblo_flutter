// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_report_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyReportListResponse _$DailyReportListResponseFromJson(
        Map<String, dynamic> json) =>
    DailyReportListResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DailyReport.fromJson(e as Map<String, dynamic>))
          .toList(),
      metaResponse: MetaResponse.fromJson(json['meta'] as Map<String, dynamic>),
      hiddenColumns: json['hidden_columns'] as String,
    );

Map<String, dynamic> _$DailyReportListResponseToJson(
        DailyReportListResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.metaResponse,
      'hidden_columns': instance.hiddenColumns,
    };
