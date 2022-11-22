// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_horse_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetHorseResponse _$GetHorseResponseFromJson(Map<String, dynamic> json) =>
    GetHorseResponse(
      data: json['data'] == null
          ? null
          : Horse.fromJson(json['data'] as Map<String, dynamic>),
      metaResponse: MetaResponse.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetHorseResponseToJson(GetHorseResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.metaResponse,
    };
