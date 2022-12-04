// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attached_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttachedFile _$AttachedFileFromJson(Map<String, dynamic> json) => AttachedFile(
      id: json['id'] as int?,
      dailyReportId: json['daily_report_id'] as int?,
      name: json['name'] as String?,
      filePath: json['file_path'] as String?,
      contentType: json['content_type'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$AttachedFileToJson(AttachedFile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'daily_report_id': instance.dailyReportId,
      'name': instance.name,
      'file_path': instance.filePath,
      'content_type': instance.contentType,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
