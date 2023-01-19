// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageListResponse _$MessageListResponseFromJson(Map<String, dynamic> json) =>
    MessageListResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Message.fromJson(e as Map<String, dynamic>))
          .toList(),
      metaResponse: MetaResponse.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MessageListResponseToJson(
        MessageListResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.metaResponse,
    };
