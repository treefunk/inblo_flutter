import 'stable.dart';
import 'user.dart';

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

  final int? id;
  final int? stableId;
  final int? ownerId;
  final int? userId;
  final int? farmId;
  final int? trainingFarmId;
  final DateTime? birthDate;
  final String? sex;
  final String? name;
  final String? color;
  final String? horseClass;
  final String? fatherName;
  final String? motherName;
  final String? motherFatherName;
  final int? totalStake;
  final String? stableName;
  final String? ownerName;
  final String? farmName;
  final String? trainingFarmName;
  final String? memo;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? archivedAt;
  final int? age;
  final User? user;
  final Stable? stable;
}
