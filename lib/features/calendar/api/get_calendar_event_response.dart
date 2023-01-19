import 'package:inblo_app/models/calendar_event.dart';
import 'package:inblo_app/models/meta_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_calendar_event_response.g.dart';

@JsonSerializable()
class GetCalendarEventResponse {
  @JsonKey(name: "data")
  CalendarEvent? data;
  @JsonKey(name: "meta")
  final MetaResponse metaResponse;

  GetCalendarEventResponse({this.data, required this.metaResponse});

  factory GetCalendarEventResponse.fromJson(Map<String, dynamic> json) =>
      _$GetCalendarEventResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetCalendarEventResponseToJson(this);
}
