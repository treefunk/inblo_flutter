// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'treatment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Treatment _$TreatmentFromJson(Map<String, dynamic> json) => Treatment(
      id: json['id'] as int?,
      horseId: json['horse_id'] as int?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      doctorName: json['doctor_name'] as String?,
      treatmentDetail: json['treatment_detail'] as String?,
      medicineName: json['medicine_name'] as String?,
      memo: json['memo'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      occasionType: json['occasion_type'] as String?,
      injuredPart: json['injured_part'] as String?,
      deletedAt: json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at'] as String),
      attachedFiles: (json['attached_files'] as List<dynamic>?)
          ?.map((e) => AttachedFile.fromJson(e as Map<String, dynamic>))
          .toList(),
      horse: json['horse'] == null
          ? null
          : Horse.fromJson(json['horse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TreatmentToJson(Treatment instance) => <String, dynamic>{
      'id': instance.id,
      'horse_id': instance.horseId,
      'date': instance.date?.toIso8601String(),
      'doctor_name': instance.doctorName,
      'treatment_detail': instance.treatmentDetail,
      'medicine_name': instance.medicineName,
      'memo': instance.memo,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'occasion_type': instance.occasionType,
      'injured_part': instance.injuredPart,
      'deleted_at': instance.deletedAt?.toIso8601String(),
      'attached_files': instance.attachedFiles,
      'horse': instance.horse,
    };
