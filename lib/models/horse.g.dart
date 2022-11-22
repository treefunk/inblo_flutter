// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'horse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Horse _$HorseFromJson(Map<String, dynamic> json) => Horse(
      id: json['id'] as int?,
      stableId: json['stableId'] as int?,
      ownerId: json['ownerId'] as int?,
      userId: json['userId'] as int?,
      farmId: json['farmId'] as int?,
      trainingFarmId: json['trainingFarmId'] as int?,
      birthDate: json['birthDate'] == null
          ? null
          : DateTime.parse(json['birthDate'] as String),
      sex: json['sex'] as String?,
      name: json['name'] as String?,
      color: json['color'] as String?,
      horseClass: json['horseClass'] as String?,
      fatherName: json['fatherName'] as String?,
      motherName: json['motherName'] as String?,
      motherFatherName: json['motherFatherName'] as String?,
      totalStake: json['totalStake'] as int?,
      stableName: json['stableName'] as String?,
      ownerName: json['ownerName'] as String?,
      farmName: json['farmName'] as String?,
      trainingFarmName: json['trainingFarmName'] as String?,
      memo: json['memo'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      archivedAt: json['archivedAt'] == null
          ? null
          : DateTime.parse(json['archivedAt'] as String),
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
      'stableId': instance.stableId,
      'ownerId': instance.ownerId,
      'userId': instance.userId,
      'farmId': instance.farmId,
      'trainingFarmId': instance.trainingFarmId,
      'birthDate': instance.birthDate?.toIso8601String(),
      'sex': instance.sex,
      'name': instance.name,
      'color': instance.color,
      'horseClass': instance.horseClass,
      'fatherName': instance.fatherName,
      'motherName': instance.motherName,
      'motherFatherName': instance.motherFatherName,
      'totalStake': instance.totalStake,
      'stableName': instance.stableName,
      'ownerName': instance.ownerName,
      'farmName': instance.farmName,
      'trainingFarmName': instance.trainingFarmName,
      'memo': instance.memo,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'archivedAt': instance.archivedAt?.toIso8601String(),
      'age': instance.age,
      'user': instance.user,
      'stable': instance.stable,
    };
