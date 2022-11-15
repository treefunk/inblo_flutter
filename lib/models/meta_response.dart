import 'package:json_annotation/json_annotation.dart';

part 'meta_response.g.dart';

@JsonSerializable()
class MetaResponse {
  MetaResponse({
    required this.message,
    required this.code,
  });

  final String message;
  final int code;

  factory MetaResponse.fromJson(Map<String, dynamic> json) =>
      _$MetaResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MetaResponseToJson(this);
}
