// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_event_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalendarEventListResponse _$CalendarEventListResponseFromJson(
        Map<String, dynamic> json) =>
    CalendarEventListResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CalendarEvent.fromJson(e as Map<String, dynamic>))
          .toList(),
      metaResponse: MetaResponse.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CalendarEventListResponseToJson(
        CalendarEventListResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.metaResponse,
    };
