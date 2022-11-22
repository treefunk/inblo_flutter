// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dropdown_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DropdownData _$DropdownDataFromJson(Map<String, dynamic> json) => DropdownData(
      id: json['id'] as int?,
      name: json['name'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$DropdownDataToJson(DropdownData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
