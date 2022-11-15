// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Stable _$StableFromJson(Map<String, dynamic> json) => Stable(
      id: json['id'] as int?,
      name: json['name'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      racetrackName: json['racetrackName'] as String?,
    );

Map<String, dynamic> _$StableToJson(Stable instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'racetrackName': instance.racetrackName,
    };
