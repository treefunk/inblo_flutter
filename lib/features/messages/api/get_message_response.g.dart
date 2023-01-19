// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_message_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMessageResponse _$GetMessageResponseFromJson(Map<String, dynamic> json) =>
    GetMessageResponse(
      data: json['data'] == null
          ? null
          : Message.fromJson(json['data'] as Map<String, dynamic>),
      metaResponse: MetaResponse.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetMessageResponseToJson(GetMessageResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.metaResponse,
    };
