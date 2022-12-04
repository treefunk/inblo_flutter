// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'horse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Horse _$HorseFromJson(Map<String, dynamic> json) => Horse(
      id: json['id'] as int?,
      stableId: json['stable_id'] as int?,
      ownerId: json['owner_id'] as int?,
      userId: json['user_id'] as int?,
      farmId: json['farm_id'] as int?,
      trainingFarmId: json['training_farm_id'] as int?,
      birthDate: json['birth_date'] == null
          ? null
          : DateTime.parse(json['birth_date'] as String),
      sex: json['sex'] as String?,
      name: json['name'] as String?,
      color: json['color'] as String?,
      horseClass: json['class'] as String?,
      fatherName: json['father_name'] as String?,
      motherName: json['mother_name'] as String?,
      motherFatherName: json['mother_father_name'] as String?,
      totalStake: (json['total_stake'] as num?)?.toDouble(),
      stableName: json['stable_name'] as String?,
      ownerName: json['owner_name'] as String?,
      farmName: json['farm_name'] as String?,
      trainingFarmName: json['training_farm_name'] as String?,
      memo: json['memo'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      archivedAt: json['archived_at'] == null
          ? null
          : DateTime.parse(json['archived_at'] as String),
      age: json['age'] as int?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      stable: json['stable'] == null
          ? null
          : Stable.fromJson(json['stable'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HorseToJson(Horse instance) => <String, dynamic>{
      'id': instance.id,
      'stable_id': instance.stableId,
      'owner_id': instance.ownerId,
      'user_id': instance.userId,
      'farm_id': instance.farmId,
      'training_farm_id': instance.trainingFarmId,
      'birth_date': instance.birthDate?.toIso8601String(),
      'sex': instance.sex,
      'name': instance.name,
      'color': instance.color,
      'class': instance.horseClass,
      'father_name': instance.fatherName,
      'mother_name': instance.motherName,
      'mother_father_name': instance.motherFatherName,
      'total_stake': instance.totalStake,
      'stable_name': instance.stableName,
      'owner_name': instance.ownerName,
      'farm_name': instance.farmName,
      'training_farm_name': instance.trainingFarmName,
      'memo': instance.memo,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'archived_at': instance.archivedAt?.toIso8601String(),
      'age': instance.age,
      'user': instance.user,
      'stable': instance.stable,
    };
