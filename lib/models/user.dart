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
  final int? roleId;
  final int? stableId;
  final String? firstName;
  final String? lastName;
  final String? username;
  final String? email;
  final String? emailVerifiedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? lastLogin;
  final Stable? stable;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
