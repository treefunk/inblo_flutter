import 'package:inblo_app/constants/app_constants.dart';
import 'package:inblo_app/models/attached_file.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

import 'horse.dart';

part 'treatment.g.dart';

@JsonSerializable()
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

  @JsonKey(name: "horse_id")
  final int? horseId;

  final DateTime? date;

  String? get formattedDate {
    if (date != null) {
      var dt = DateTime.parse(date.toString());
      return DateFormat(AppConstants.dateOnlyFormatYmd).format(dt);
    }
    return null;
  }

  @JsonKey(name: "doctor_name")
  final String? doctorName;

  @JsonKey(name: "treatment_detail")
  final String? treatmentDetail;

  @JsonKey(name: "medicine_name")
  final String? medicineName;

  @JsonKey(name: "memo")
  final String? memo;

  @JsonKey(name: "created_at")
  final DateTime? createdAt;

  @JsonKey(name: "updated_at")
  final DateTime? updatedAt;

  @JsonKey(name: "occasion_type")
  final String? occasionType;

  @JsonKey(name: "injured_part")
  final String? injuredPart;

  @JsonKey(name: "deleted_at")
  final DateTime? deletedAt;

  @JsonKey(name: "attached_files")
  final List<AttachedFile>? attachedFiles;

  final Horse? horse;

  factory Treatment.fromJson(Map<String, dynamic> json) =>
      _$TreatmentFromJson(json);

  Map<String, dynamic> toJson() => _$TreatmentToJson(this);
}
