import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:inblo_app/common_widgets/general_dialog.dart';
import 'package:inblo_app/common_widgets/inblo_sub_header.dart';
import 'package:inblo_app/common_widgets/inblo_text_button.dart';
import 'package:inblo_app/common_widgets/inblo_white_rounded_button.dart';
import 'package:inblo_app/constants/app_theme.dart';
import 'package:inblo_app/constants/text_styles.dart';
import 'package:inblo_app/features/calendar/presentation/add_event_dialog.dart';
import 'package:inblo_app/features/calendar/provider/calendar_events.dart';
import 'package:inblo_app/features/calendar/widget/inblo_event_tile.dart';
import 'package:inblo_app/models/calendar_event.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:inblo_app/constants/my_ext.dart';

import '../utils.dart';

// import '../utils.dart';

class InbloCalendar extends StatefulWidget {
  const InbloCalendar({super.key});

  @override
  State<InbloCalendar> createState() => _InbloCalendarState();
}

class _InbloCalendarState extends State<InbloCalendar> {
  // late final Future _getCalendarEventsFuture;

  late final ValueNotifier<List<CalendarEvent>> _selectedEvents;

  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  Future<void> getEvents(int month, int year, int? horseId) async {
    await Provider.of<CalendarEvents>(context, listen: false)
        .fetchEventsByMonthYear(month, year, horseId);
  }

  @override
  void initState() {
    super.initState();

    final today = DateTime.now();

    getEvents(today.month, today.year, null);

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  List<CalendarEvent> _getEventsForDay(DateTime day) {
    // Implementation example
    // print("Get events here: $day");
    var events = Provider.of<CalendarEvents>(context, listen: false)
        .filteredCalendarEvents;
    if (events[day] != null && events[day]!.isNotEmpty) {
      print("event found in get events");
    }
    return events[day] ?? [];
  }

  // List<CalendarEvent> _getEventsForRange(DateTime start, DateTime end) {
  //   // Implementation example
  //   final days = daysInRange(start, end);

  //   return [
  //     for (final d in days) ..._getEventsForDay(d),
  //   ];
  // }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    final kToday = DateTime.now();
    final kFirstDay = DateTime(kToday.year, kToday.month - 36, kToday.day);
    final kLastDay = DateTime(kToday.year, kToday.month + 36, kToday.day);

    context.watch<CalendarEvents>().filteredCalendarEvents;
    print("inblo calendar build");

    return Column(
      children: [
        TableCalendar<CalendarEvent>(
          firstDay: kFirstDay,
          lastDay: kLastDay,
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          rangeSelectionMode: _rangeSelectionMode,
          eventLoader: _getEventsForDay,
          startingDayOfWeek: StartingDayOfWeek.monday,
          calendarStyle: CalendarStyle(
            // Use `CalendarStyle` to customize the UI
            outsideDaysVisible: false,
            // defaultTextStyle: TextStyle(fontSize: 30),
          ),
          headerStyle: HeaderStyle(
            titleCentered: true,
          ),
          onDaySelected: _onDaySelected,
          availableCalendarFormats: {CalendarFormat.month: "Month"},
          onPageChanged: (DateTime focusedDay) async {
            setState(() {
              _focusedDay = focusedDay;
            });
            getEvents(focusedDay.month, focusedDay.year, null);
            print("focused day: ${focusedDay}");
          },
        ),
        const SizedBox(height: 8.0),
        InbloSubHeader(
          title: "イベント予定",
          textOnly: true,
          trailing: InbloTextButton(
            onPressed: () {
              showCustomDialog(
                context: context,
                title: "状態入力",
                content: (ctx) => Container(),
              );
            },
            title: "イベントを追加",
            padding: 0,
            textStyle: TextStyleInbloButton.medium,
            iconPrefix: Icon(
              Icons.add_circle_outline,
              size: 18,
              color: Colors.white,
            ),
          ),
        ),
        // Expanded(
        //   child: Container(
        //     color: colorDarkBackground,
        //     child: ValueListenableBuilder<List<CalendarEvent>>(
        //       valueListenable: _selectedEvents,
        //       builder: (context, value, _) {
        //         return ListView.builder(
        //           itemCount: value.length,
        //           itemBuilder: (context, index) {
        //             // return InbloEventTile();
        //           },
        //         );
        //       },
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
