import 'dart:collection';
import 'dart:convert';

import 'package:cr_calendar/cr_calendar.dart';
import 'package:flutter/foundation.dart';
import 'package:inblo_app/constants/app_constants.dart';
import 'package:inblo_app/constants/app_theme.dart';
import 'package:inblo_app/features/auth/api/boolean_response.dart';
import 'package:inblo_app/features/calendar/api/calendar_event_list_response.dart';
import 'package:inblo_app/features/calendar/api/get_calendar_event_response.dart';
import 'package:inblo_app/models/calendar_event.dart';
import 'package:inblo_app/models/stable.dart';
import 'package:inblo_app/models/user.dart';
import 'package:inblo_app/models/user_details.dart';
import 'package:inblo_app/util/preference_utils.dart';
import 'package:inblo_app/constants/my_ext.dart';
import 'package:http/http.dart' as http;
import 'package:table_calendar/table_calendar.dart';

class CalendarEvents with ChangeNotifier {
  CalendarEvents();

  List<CalendarEvent> _calendarEvents = [
    //
  ];

  List<CalendarEvent> get calendarEvents {
    return [..._calendarEvents];
  }

  List<CalendarEventModel> calendarTiles = [];

  Map<DateTime, List<CalendarEvent>> filteredCalendarEvents = {};

  Future<void> getFilteredCalendarEvent(
    int month,
    int year,
  ) async {
    int numOfEventsFound = 0;
    Map<DateTime, List<CalendarEvent>> events = {};
    List<CalendarEvent> eventsFound = [];
    for (int i = 1; i <= DateTime(i, month, 0).day; i++) {
      var day = DateTime.utc(year, month, i);
      List<CalendarEvent> dayEvents = [];
      for (int j = 0; j < _calendarEvents.length; j++) {
        var event = _calendarEvents[j];
        if ((event.date.day < day.day &&
                event.dateEnd.day > day.day) || // between date
            (event.date.day == day.day && event.dateEnd.day == day.day)) {
          dayEvents.add(event);
        }
      }

      var userDetails = await PreferenceUtils.getUserDetails();

      List<CalendarEvent> sampleEvents = [
        CalendarEvent(
          id: 1,
          horseId: null,
          userId: 11,
          stableId: 2,
          date: day,
          title: "test",
          eventType: "レース予定",
          start: "00:00",
          end: "06:00",
          memo: "test",
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          dateEnd: day,
          horse: null,
          user: User(id: userDetails.userId, username: "jhondz"),
          stable: Stable(id: 2),
        ),
        CalendarEvent(
          id: 1,
          horseId: null,
          userId: 11,
          stableId: 2,
          date: day,
          title: "test",
          eventType: "レース予定",
          start: "00:00",
          end: "06:00",
          memo: "test",
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          dateEnd: day,
          horse: null,
          user: User(id: userDetails.userId, username: "jhondz"),
          stable: Stable(id: 2),
        )
      ];

      events.putIfAbsent(day, () => sampleEvents);

      // events[day] = dayEvents;

      // var dayEvents = _calendarEvents.where(
      //   (event) {
      //     var hasEvent = (event.date.day < day.day &&
      //             event.dateEnd.day > day.day) || // between date
      //         (event.date.day == day.day &&
      //             event.dateEnd.day == day.day); // same day dates

      //     return hasEvent;
      //   },
      // ).toList();
      // events[day] = dayEvents;

      // events[day] = [];
    }

    filteredCalendarEvents.clear();

    filteredCalendarEvents = LinkedHashMap<DateTime, List<CalendarEvent>>(
      equals: isSameDay,
      hashCode: getHashCode,
      // hashCode: getHashCode,
    )..addAll(events);

    print(filteredCalendarEvents);
    if (numOfEventsFound > 0) {
      print("number of events found -> $numOfEventsFound");
    }

    notifyListeners();

    // print(i)
  }

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  void setCalendarEvents(List<CalendarEvent> calendarEvents) {
    _calendarEvents = calendarEvents;
  }

  Future<List<CalendarEvent>> fetchEventsByMonthYear(
      int month, int year, int? horseId) async {
    var urlStr = "";

    var monthWithPrefix = month.withZeroPrefix();

    if (horseId == null) {
      UserDetails userDetails = await PreferenceUtils.getUserDetails();

      urlStr =
          "${AppConstants.apiUrl}/events/stable/${userDetails.stableId}/month/$monthWithPrefix/year/$year";
    } else {
      urlStr =
          "${AppConstants.apiUrl}/events/horse/$horseId/month/$monthWithPrefix/year/$year";
    }

    print(urlStr);

    final url = Uri.parse(urlStr);
    final response = await http.get(url);

    var jsonResponse = json.decode(response.body);
    print("fetching calendar events for $month/$year...");
    // print(jsonResponse);
    var result = CalendarEventListResponse.fromJson(jsonResponse);
    print(result.metaResponse.message);
    _calendarEvents = result.data ?? [];
    calendarTiles = calendarEvents
        .map((calendarEvent) => CalendarEventModel(
              name: calendarEvent.title,
              begin: calendarEvent.date,
              end: calendarEvent.dateEnd,
              eventColor: colorPrimaryDark,
            ))
        .toList();
    notifyListeners();

    return result.data ?? [];
  }

  Future<GetCalendarEventResponse> addCalendarEvent(
    int? horseId,
    String date,
    String? dateEnd,
    String title,
    String eventType,
    String start,
    String end,
    String memo,
    int? eventId,
    // DateTime activeDateTime, // for refreshing
  ) async {
    UserDetails userDetails = await PreferenceUtils.getUserDetails();

    var urlStr = "${AppConstants.apiUrl}/events";

    if (eventId != null) {
      urlStr += "/$eventId";
    }
    final url = Uri.parse(urlStr);

    final Map<String, dynamic> eventsData = {
      'user_id': userDetails.userId.toString(),
      'event_type': eventType,
      'title': title,
      'date': date,
      'start': start,
      'end': end,
      'memo': memo,
      'stable_id': userDetails.stableId.toString()
    };

    if (horseId != null) {
      eventsData['horse_id'] = horseId.toString();
    } else {
      eventsData['horse_id'] = null;
    }

    if (dateEnd != null) {
      eventsData['date_end'] = dateEnd;
    }

    var encodedInput = json.encode(eventsData);

    http.Response response;

    print("url: $url");

    if (eventId == null) {
      // if no id is given, add horse
      response = await http.post(
        url,
        body: encodedInput,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
      );
      print("creating event..");
    } else {
      // update horse
      response = await http.put(
        url,
        body: encodedInput,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
      );
      print("updating existing event");
    }

    var jsonResponse = json.decode(response.body);

    print(jsonResponse);

    var result = GetCalendarEventResponse.fromJson(jsonResponse);

    // if (result.metaResponse.code == 201) {
    //   await fetchEventsByMonthYear(
    //       activeDateTime.year, activeDateTime.month, horseId);
    // }
    return result;
  }

  Future<BooleanResponse> deleteCalendarEvent(int eventId) async {
    var urlStr = "${AppConstants.apiUrl}/events/$eventId";
    var response = await http.delete(Uri.parse(urlStr));

    var decodedResponse = json.decode(response.body);

    print(decodedResponse);
    BooleanResponse result = BooleanResponse.fromJson(decodedResponse);

    if (result.metaResponse.code == 201) {
      // await fetchDailyReports();
      notifyListeners();
    }

    return result;
  }
}
