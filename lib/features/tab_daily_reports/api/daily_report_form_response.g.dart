// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_report_form_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyReportFormResponse _$DailyReportFormResponseFromJson(
        Map<String, dynamic> json) =>
    DailyReportFormResponse(
      data: json['data'] == null
          ? null
          : DailyReportForm.fromJson(json['data'] as Map<String, dynamic>),
      metaResponse: MetaResponse.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DailyReportFormResponseToJson(
        DailyReportFormResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.metaResponse,
    };
