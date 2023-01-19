import 'package:flutter/material.dart';
import 'package:inblo_app/features/calendar/provider/event_types.dart';
import 'package:json_annotation/json_annotation.dart';

import 'horse.dart';
import 'stable.dart';
import 'user.dart';

part 'calendar_event.g.dart';

@JsonSerializable()
class CalendarEvent {
  CalendarEvent({
    required this.id,
    required this.horseId,
    required this.userId,
    required this.stableId,
    required this.date,
    required this.title,
    required this.eventType,
    required this.start,
    required this.end,
    required this.memo,
    required this.createdAt,
    required this.updatedAt,
    required this.dateEnd,
    required this.horse,
    required this.user,
    required this.stable,
  });

  final int id;

  @JsonKey(name: "horse_id")
  final int? horseId;

  @JsonKey(name: "user_id")
  final int userId;

  @JsonKey(name: "stable_id")
  final int stableId;

  final DateTime date;

  final String title;

  @JsonKey(name: "event_type")
  final String eventType;

  final String start;

  final String end;

  final String memo;

  @JsonKey(name: "created_at")
  final DateTime createdAt;

  @JsonKey(name: "updated_at")
  final DateTime updatedAt;

  @JsonKey(name: "date_end")
  final DateTime dateEnd;

  final Horse? horse;

  final User user;

  final Stable stable;

  CalendarEventType get calendarEventType {
    return CalendarEventType.values
        .firstWhere((CalendarEventType calEvent) => calEvent.name == eventType);
  }

  factory CalendarEvent.fromJson(Map<String, dynamic> json) =>
      _$CalendarEventFromJson(json);

  Map<String, dynamic> toJson() => _$CalendarEventToJson(this);
}
