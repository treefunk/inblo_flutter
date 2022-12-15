import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as path;

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
    this.webFile,
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

  @JsonKey(ignore: true)
  final Uint8List? webFile;

  factory AttachedFile.fromJson(Map<String, dynamic> json) =>
      _$AttachedFileFromJson(json);

  Map<String, dynamic> toJson() => _$AttachedFileToJson(this);

  static AttachedFile fromXFile(XFile xfile) => AttachedFile(
        name: path.basename(xfile.path),
        filePath: xfile.path,
        contentType: lookupMimeType(xfile.path),
      );

  static List<AttachedFile> fromXFileList(List<XFile> xfiles) =>
      xfiles.map((xf) => AttachedFile.fromXFile(xf)).toList();

  static AttachedFile fromFile(File file) => AttachedFile(
        name: path.basename(file.path),
        filePath: file.path,
        contentType: lookupMimeType(file.path),
      );

  static AttachedFile fromU8intList(String filename, Uint8List uint8list) =>
      AttachedFile(name: filename, filePath: filename, webFile: uint8list);
}
