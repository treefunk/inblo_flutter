import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:cell_calendar/cell_calendar.dart';

// import '../utils.dart';

List<CalendarEvent> sampleEvents() {
  final today = DateTime.now();
  final eventTextStyle = TextStyle(
    fontSize: 9,
    color: Colors.white,
  );
  final sampleEvents = [
    CalendarEvent(
      eventName: "New iPhone",
      eventDate: today.add(Duration(days: -42)),
      eventBackgroundColor: Colors.black,
    ),
    CalendarEvent(
      eventName: "Writing test",
      eventDate: today.add(Duration(days: -30)),
      eventBackgroundColor: Colors.deepOrange,
    ),
    CalendarEvent(
      eventName: "Play soccer",
      eventDate: today.add(Duration(days: -7)),
      eventBackgroundColor: Colors.greenAccent,
    ),
    CalendarEvent(
      eventName: "Learn about history",
      eventDate: today.add(
        Duration(days: -7),
      ),
    ),
    CalendarEvent(
      eventName: "Buy new keyboard",
      eventDate: today.add(
        Duration(days: -7),
      ),
    ),
    CalendarEvent(
      eventName: "Walk around the park",
      eventDate: today.add(Duration(days: -7)),
      eventBackgroundColor: Colors.deepOrange,
    ),
    CalendarEvent(
      eventName: "Buy a present for Rebecca",
      eventDate: today.add(Duration(days: -7)),
      eventBackgroundColor: Colors.pink,
    ),
    CalendarEvent(
      eventName: "Firebase",
      eventDate: today.add(
        Duration(days: -7),
      ),
    ),
    CalendarEvent(
      eventName: "Task deadline",
      eventDate: today,
    ),
    CalendarEvent(
      eventName: "Jon's Birthday",
      eventDate: today.add(
        Duration(days: 3),
      ),
      eventBackgroundColor: Colors.green,
    ),
    CalendarEvent(
      eventName: "Date with Rebecca",
      eventDate: today.add(Duration(days: 7)),
      eventBackgroundColor: Colors.pink,
    ),
    CalendarEvent(
      eventName: "Start to study Spanish",
      eventDate: today.add(
        Duration(days: 13),
      ),
    ),
    CalendarEvent(
      eventName: "Have lunch with Mike",
      eventDate: today.add(Duration(days: 13)),
      eventBackgroundColor: Colors.green,
    ),
    CalendarEvent(
      eventName: "Buy new Play Station software",
      eventDate: today.add(Duration(days: 13)),
      eventBackgroundColor: Colors.indigoAccent,
    ),
    CalendarEvent(
      eventName: "Update my flutter package",
      eventDate: today.add(
        Duration(days: 13),
      ),
    ),
    CalendarEvent(
      eventName: "Watch movies in my house",
      eventDate: today.add(
        Duration(days: 21),
      ),
    ),
    CalendarEvent(
      eventName: "Medical Checkup",
      eventDate: today.add(Duration(days: 30)),
      eventBackgroundColor: Colors.red,
    ),
    CalendarEvent(
      eventName: "Gym",
      eventDate: today.add(Duration(days: 42)),
      eventBackgroundColor: Colors.indigoAccent,
    ),
  ];
  return sampleEvents;
}

class InbloCalendarAlt extends StatelessWidget {
  InbloCalendarAlt({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    final _sampleEvents = sampleEvents();
    final cellCalendarPageController = CellCalendarPageController();
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: CellCalendar(
        cellCalendarPageController: cellCalendarPageController,
        events: _sampleEvents,
        daysOfTheWeekBuilder: (dayIndex) {
          final labels = ["S", "M", "T", "W", "T", "F", "S"];
          return Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              labels[dayIndex],
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          );
        },
        monthYearLabelBuilder: (datetime) {
          final year = datetime!.year.toString();
          final month = datetime!.month.monthName;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                const SizedBox(width: 16),
                Text(
                  "$month  $year",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.calendar_month),
                  onPressed: () async {
                    cellCalendarPageController
                        .jumpToDate(datetime.add(Duration(days: 20)));
                  },
                )
              ],
            ),
          );
        },
        onCellTapped: (date) {
          final eventsOnTheDate = _sampleEvents.where((event) {
            final eventDate = event.eventDate;
            return eventDate.year == date.year &&
                eventDate.month == date.month &&
                eventDate.day == date.day;
          }).toList();
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    title:
                        Text(date.month.monthName + " " + date.day.toString()),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: eventsOnTheDate
                          .map(
                            (event) => Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(4),
                              margin: EdgeInsets.only(bottom: 12),
                              color: event.eventBackgroundColor,
                              child: Text(
                                event.eventName,
                                style: TextStyle(color: event.eventTextColor),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ));
        },
        onPageChanged: (firstDate, lastDate) {
          /// Called when the page was changed
          /// Fetch additional events by using the range between [firstDate] and [lastDate] if you want
        },
      ),
    );
  }
}
