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
  final int? dailyReportId;
  final String? name;
  final String? filePath;
  final String? contentType;
  final DateTime? createdAt;
  final DateTime? updatedAt;
}
