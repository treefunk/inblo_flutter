import 'package:json_annotation/json_annotation.dart';

part 'stable.g.dart';

@JsonSerializable()
class Stable {
  Stable({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.racetrackName,
  });

  final int? id;
  final String? name;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? racetrackName;

  factory Stable.fromJson(Map<String, dynamic> json) => _$StableFromJson(json);

  Map<String, dynamic> toJson() => _$StableToJson(this);
}
