// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyReport _$DailyReportFromJson(Map<String, dynamic> json) => DailyReport(
      id: json['id'] as int?,
      horseId: json['horse_id'] as int?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      bodyTemperature: (json['body_temperature'] as num?)?.toDouble(),
      horseWeight: json['horse_weight'] as int?,
      conditionGroup: json['condition_group'] as String?,
      riderName: json['rider_name'] as String?,
      trainingTypeName: json['training_type_name'] as String?,
      trainingAmount: json['training_amount'] as String?,
      time5f: (json['5f_time'] as num?)?.toDouble(),
      time4f: (json['4f_time'] as num?)?.toDouble(),
      time3f: (json['3f_time'] as num?)?.toDouble(),
      memo: json['memo'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      trainingTypeId: json['training_type_id'] as int?,
      riderId: json['rider_id'] as int?,
      deletedAt: json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at'] as String),
      attachedFiles: (json['attached_files'] as List<dynamic>?)
          ?.map((e) => AttachedFile.fromJson(e as Map<String, dynamic>))
          .toList(),
      trainingType: json['training_type'] == null
          ? null
          : DropdownData.fromJson(
              json['training_type'] as Map<String, dynamic>),
      rider: json['rider'] == null
          ? null
          : DropdownData.fromJson(json['rider'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DailyReportToJson(DailyReport instance) =>
    <String, dynamic>{
      'id': instance.id,
      'horse_id': instance.horseId,
      'date': instance.date?.toIso8601String(),
      'body_temperature': instance.bodyTemperature,
      'horse_weight': instance.horseWeight,
      'condition_group': instance.conditionGroup,
      'rider_name': instance.riderName,
      'training_type_name': instance.trainingTypeName,
      'training_amount': instance.trainingAmount,
      '5f_time': instance.time5f,
      '4f_time': instance.time4f,
      '3f_time': instance.time3f,
      'memo': instance.memo,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'training_type_id': instance.trainingTypeId,
      'rider_id': instance.riderId,
      'deleted_at': instance.deletedAt?.toIso8601String(),
      'attached_files': instance.attachedFiles,
      'training_type': instance.trainingType,
      'rider': instance.rider,
    };
