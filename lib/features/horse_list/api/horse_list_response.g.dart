// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'horse_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HorseListResponse _$HorseListResponseFromJson(Map<String, dynamic> json) =>
    HorseListResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Horse.fromJson(e as Map<String, dynamic>))
          .toList(),
      metaResponse: MetaResponse.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HorseListResponseToJson(HorseListResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.metaResponse,
    };
