import 'package:json_annotation/json_annotation.dart';

import 'stable.dart';
import 'user.dart';

part 'horse.g.dart';

@JsonSerializable()
class Horse {
  Horse({
    this.id,
    this.stableId,
    this.ownerId,
    this.userId,
    this.farmId,
    this.trainingFarmId,
    this.birthDate,
    this.sex,
    this.name,
    this.color,
    this.horseClass,
    this.fatherName,
    this.motherName,
    this.motherFatherName,
    this.totalStake,
    this.stableName,
    this.ownerName,
    this.farmName,
    this.trainingFarmName,
    this.memo,
    this.createdAt,
    this.updatedAt,
    this.archivedAt,
    this.age,
    this.user,
    this.stable,
  });

  int? id;
  int? stableId;
  int? ownerId;
  int? userId;
  int? farmId;
  int? trainingFarmId;
  DateTime? birthDate;
  String? sex;
  String? name;
  String? color;
  String? horseClass;
  String? fatherName;
  String? motherName;
  String? motherFatherName;
  int? totalStake;
  String? stableName;
  String? ownerName;
  String? farmName;
  String? trainingFarmName;
  String? memo;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? archivedAt;
  int? age;
  User? user;
  Stable? stable;

  factory Horse.fromJson(Map<String, dynamic> json) => _$HorseFromJson(json);

  Map<String, dynamic> toJson() => _$HorseToJson(this);
}
