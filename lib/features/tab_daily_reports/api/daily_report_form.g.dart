// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_report_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyReportForm _$DailyReportFormFromJson(Map<String, dynamic> json) =>
    DailyReportForm(
      trainingTypes: (json['training_types'] as List<dynamic>)
          .map((e) => DropdownData.fromJson(e as Map<String, dynamic>))
          .toList(),
      riders: (json['riders'] as List<dynamic>)
          .map((e) => DropdownData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DailyReportFormToJson(DailyReportForm instance) =>
    <String, dynamic>{
      'training_types': instance.trainingTypes,
      'riders': instance.riders,
    };
