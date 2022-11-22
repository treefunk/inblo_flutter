import 'package:json_annotation/json_annotation.dart';

part 'dropdown_data.g.dart';

@JsonSerializable()
class DropdownData {
  DropdownData({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String? name;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory DropdownData.fromJson(Map<String, dynamic> json) =>
      _$DropdownDataFromJson(json);

  Map<String, dynamic> toJson() => _$DropdownDataToJson(this);
}
