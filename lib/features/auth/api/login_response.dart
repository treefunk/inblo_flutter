import 'package:inblo_app/models/meta_response.dart';
import 'package:inblo_app/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final User? data;
  final MetaResponse metaResponse;

  LoginResponse({this.data, required this.metaResponse});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
