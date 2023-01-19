// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_calendar_event_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCalendarEventResponse _$GetCalendarEventResponseFromJson(
        Map<String, dynamic> json) =>
    GetCalendarEventResponse(
      data: json['data'] == null
          ? null
          : CalendarEvent.fromJson(json['data'] as Map<String, dynamic>),
      metaResponse: MetaResponse.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetCalendarEventResponseToJson(
        GetCalendarEventResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.metaResponse,
    };
