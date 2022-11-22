import 'stable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  User({
    this.id,
    this.roleId,
    this.stableId,
    this.firstName,
    this.lastName,
    this.username,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.lastLogin,
    this.stable,
  });

  final int? id;

  @JsonKey(name: "role_id")
  final int? roleId;

  @JsonKey(name: "stable_id")
  final int? stableId;

  @JsonKey(name: "first_name")
  final String? firstName;

  @JsonKey(name: "last_name")
  final String? lastName;

  final String? username;

  final String? email;

  final String? emailVerifiedAt;

  @JsonKey(name: "created_at")
  final DateTime? createdAt;

  @JsonKey(name: "updated_at")
  final DateTime? updatedAt;

  @JsonKey(name: "last_login")
  final dynamic lastLogin;

  final Stable? stable;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
