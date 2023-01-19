import 'package:inblo_app/models/calendar_event.dart';
import 'package:inblo_app/models/meta_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'calendar_event_list_response.g.dart';

@JsonSerializable()
class CalendarEventListResponse {
  @JsonKey(name: "data")
  List<CalendarEvent>? data;
  @JsonKey(name: "meta")
  final MetaResponse metaResponse;

  CalendarEventListResponse({this.data, required this.metaResponse});

  factory CalendarEventListResponse.fromJson(Map<String, dynamic> json) =>
      _$CalendarEventListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CalendarEventListResponseToJson(this);
}
