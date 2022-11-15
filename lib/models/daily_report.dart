import 'package:inblo_app/models/attached_file.dart';

class DailyReport {
  DailyReport({
    this.id,
    this.horseId,
    this.date,
    this.bodyTemperature,
    this.horseWeight,
    this.conditionGroup,
    this.riderName,
    this.trainingTypeName,
    this.trainingAmount,
    this.time5f,
    this.time4f,
    this.time3f,
    this.memo,
    this.createdAt,
    this.updatedAt,
    this.trainingTypeId,
    this.riderId,
    this.deletedAt,
    this.attachedFiles,
    this.trainingType,
    this.rider,
  });

  final int? id;
  final int? horseId;
  final DateTime? date;
  final int? bodyTemperature;
  final int? horseWeight;
  final String? conditionGroup;
  final String? riderName;
  final String? trainingTypeName;
  final String? trainingAmount;
  final double? time5f;
  final double? time4f;
  final double? time3f;
  final String? memo;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? trainingTypeId;
  final int? riderId;
  final DateTime? deletedAt;
  final List<AttachedFile>? attachedFiles;
  final int? trainingType;
  final int? rider;
}
