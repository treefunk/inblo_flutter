import 'package:inblo_app/models/user.dart';
import 'package:inblo_app/models/meta_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_users_response.g.dart';

@JsonSerializable()
class GetUsersResponse {
  @JsonKey(name: "data")
  List<User>? data;
  @JsonKey(name: "meta")
  final MetaResponse metaResponse;

  GetUsersResponse({this.data, required this.metaResponse});

  factory GetUsersResponse.fromJson(Map<String, dynamic> json) =>
      _$GetUsersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetUsersResponseToJson(this);
}
