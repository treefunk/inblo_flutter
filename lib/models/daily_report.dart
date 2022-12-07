import 'package:inblo_app/constants/app_constants.dart';
import 'package:inblo_app/models/attached_file.dart';
import 'package:inblo_app/models/dropdown_data.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'daily_report.g.dart';

@JsonSerializable()
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

  @JsonKey(name: "body_temperature")
  final double? bodyTemperature;

  @JsonKey(name: "horse_weight")
  final int? horseWeight;

  @JsonKey(name: "condition_group")
  final String? conditionGroup;

  @JsonKey(name: "rider_name")
  final String? riderName;

  @JsonKey(name: "training_type_name")
  final String? trainingTypeName;

  @JsonKey(name: "training_amount")
  final String? trainingAmount;

  @JsonKey(name: "5f_time")
  final double? time5f;

  @JsonKey(name: "4f_time")
  final double? time4f;

  @JsonKey(name: "3f_time")
  final double? time3f;

  final String? memo;

  @JsonKey(name: "created_at")
  final DateTime? createdAt;

  @JsonKey(name: "updated_at")
  final DateTime? updatedAt;

  @JsonKey(name: "training_type_id")
  final int? trainingTypeId;

  @JsonKey(name: "rider_id")
  final int? riderId;

  @JsonKey(name: "deleted_at")
  final DateTime? deletedAt;

  @JsonKey(name: "attached_files")
  final List<AttachedFile>? attachedFiles;

  @JsonKey(name: "training_type")
  final DropdownData? trainingType;

  @JsonKey(name: "rider")
  final DropdownData? rider;

  factory DailyReport.fromJson(Map<String, dynamic> json) =>
      _$DailyReportFromJson(json);

  Map<String, dynamic> toJson() => _$DailyReportToJson(this);
}
