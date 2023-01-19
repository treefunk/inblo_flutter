// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalendarEvent _$CalendarEventFromJson(Map<String, dynamic> json) =>
    CalendarEvent(
      id: json['id'] as int,
      horseId: json['horse_id'] as int?,
      userId: json['user_id'] as int,
      stableId: json['stable_id'] as int,
      date: DateTime.parse(json['date'] as String),
      title: json['title'] as String,
      eventType: json['event_type'] as String,
      start: json['start'] as String,
      end: json['end'] as String,
      memo: json['memo'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      dateEnd: DateTime.parse(json['date_end'] as String),
      horse: json['horse'] == null
          ? null
          : Horse.fromJson(json['horse'] as Map<String, dynamic>),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      stable: Stable.fromJson(json['stable'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CalendarEventToJson(CalendarEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'horse_id': instance.horseId,
      'user_id': instance.userId,
      'stable_id': instance.stableId,
      'date': instance.date.toIso8601String(),
      'title': instance.title,
      'event_type': instance.eventType,
      'start': instance.start,
      'end': instance.end,
      'memo': instance.memo,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'date_end': instance.dateEnd.toIso8601String(),
      'horse': instance.horse,
      'user': instance.user,
      'stable': instance.stable,
    };
