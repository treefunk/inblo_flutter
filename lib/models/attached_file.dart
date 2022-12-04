import 'package:json_annotation/json_annotation.dart';

part 'attached_file.g.dart';

@JsonSerializable()
class AttachedFile {
  AttachedFile({
    this.id,
    this.dailyReportId,
    this.name,
    this.filePath,
    this.contentType,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  @JsonKey(name: "daily_report_id")
  final int? dailyReportId;
  final String? name;
  @JsonKey(name: "file_path")
  final String? filePath;
  @JsonKey(name: "content_type")
  final String? contentType;
  @JsonKey(name: "created_at")
  final DateTime? createdAt;
  @JsonKey(name: "updated_at")
  final DateTime? updatedAt;

  factory AttachedFile.fromJson(Map<String, dynamic> json) =>
      _$AttachedFileFromJson(json);

  Map<String, dynamic> toJson() => _$AttachedFileToJson(this);
}
