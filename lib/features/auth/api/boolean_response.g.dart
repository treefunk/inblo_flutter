// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'boolean_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BooleanResponse _$BooleanResponseFromJson(Map<String, dynamic> json) =>
    BooleanResponse(
      data: json['data'] as bool?,
      metaResponse: MetaResponse.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BooleanResponseToJson(BooleanResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.metaResponse,
    };
