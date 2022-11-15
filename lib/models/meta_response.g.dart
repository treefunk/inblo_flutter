// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meta_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MetaResponse _$MetaResponseFromJson(Map<String, dynamic> json) => MetaResponse(
      message: json['message'] as String,
      code: json['code'] as int,
    );

Map<String, dynamic> _$MetaResponseToJson(MetaResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
    };
