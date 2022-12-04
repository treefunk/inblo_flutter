import 'package:inblo_app/models/dropdown_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'daily_report_form.g.dart';

@JsonSerializable()
class DailyReportForm {
  @JsonKey(name: "training_types")
  List<DropdownData> trainingTypes;

  @JsonKey(name: "riders")
  List<DropdownData> riders;

  DailyReportForm({required this.trainingTypes, required this.riders});

  factory DailyReportForm.fromJson(Map<String, dynamic> json) =>
      _$DailyReportFormFromJson(json);

  Map<String, dynamic> toJson() => _$DailyReportFormToJson(this);
}
