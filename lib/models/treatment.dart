import 'horse.dart';

class Treatment {
  Treatment({
    this.id,
    this.horseId,
    this.date,
    this.doctorName,
    this.treatmentDetail,
    this.medicineName,
    this.memo,
    this.createdAt,
    this.updatedAt,
    this.occasionType,
    this.injuredPart,
    this.deletedAt,
    this.attachedFiles,
    this.horse,
  });

  final int? id;
  final int? horseId;
  final DateTime? date;
  final String? doctorName;
  final String? treatmentDetail;
  final String? medicineName;
  final String? memo;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? occasionType;
  final String? injuredPart;
  final DateTime? deletedAt;
  final List<dynamic>? attachedFiles;
  final Horse? horse;
}
