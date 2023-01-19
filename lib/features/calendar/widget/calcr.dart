import 'package:cr_calendar/cr_calendar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:inblo_app/common_widgets/general_dialog.dart';
import 'package:inblo_app/common_widgets/inblo_outlined_button.dart';
import 'package:inblo_app/common_widgets/inblo_sub_header.dart';
import 'package:inblo_app/common_widgets/inblo_text_button.dart';
import 'package:inblo_app/constants/app_theme.dart';
import 'package:inblo_app/constants/my_ext.dart';
import 'package:inblo_app/features/calendar/presentation/add_event_dialog.dart';
import 'package:inblo_app/features/calendar/provider/calendar_events.dart';
import 'package:inblo_app/features/calendar/provider/event_types.dart';
import 'package:inblo_app/features/calendar/widget/view_event_dialog.dart';
import 'package:inblo_app/models/calendar_event.dart';
import 'package:inblo_app/models/horse.dart';
import 'package:provider/provider.dart';

import '../../horse_list/providers/horses.dart';
import 'inblo_event_tile.dart';

class Calcr extends StatefulWidget {
  const Calcr({this.horse, super.key});
  final Horse? horse;

  @override
  _CalcrState createState() => _CalcrState();
}

const kAppBarDateFormat = 'M/yyyy';
const kMonthFormat = 'MMMM';
const kMonthFormatWidthYear = 'MMMM yyyy';
const kDateRangeFormat = 'dd-MM-yy';

class _CalcrState extends State<Calcr> {
  late String _appbarTitle;
  late String _monthAndYearName;

  late final Future getHorsesFuture;

  final _currentDate = DateTime.now();

  late CrCalendarController _calendarController;

  List<CalendarEvent> _monthEvents = [];
  final List<CalendarEventModel> _events = [];
  List<CalendarEvent> _dayEvents = [];
  bool fetchingData = false;

  List<CalendarEventType> _foundFilters = [];
  List<CalendarEventType> _activatedFilters = [];

  List<CalendarEvent> get filteredDayEvents {
    return _dayEvents.where((dayEvent) {
      return _activatedFilters.contains(dayEvent.calendarEventType);
    }).toList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _setTexts(_currentDate.year, _currentDate.month);
    final now = _currentDate;

    _calendarController = CrCalendarController(
      onSwipe: _onCalendarPageChanged,
      events: _events,
    );
    _fetchEvents(_currentDate.month, _currentDate.year, widget.horse?.id);
    getHorsesFuture = Provider.of<Horses>(context, listen: false).fetchHorses();

    super.initState();
  }

  // events below the calendar
  void _fetchDayEvents(List<CalendarEventModel> calendarEventModels) {
    _dayEvents.clear();
    List<CalendarEvent> foundDayEvents = [];
    for (var i = 0; i < calendarEventModels.length; i++) {
      var calendarEventModel = calendarEventModels[i];
      var eventFound = _monthEvents.firstWhere(
        (event) =>
            (event.date == calendarEventModel.begin &&
                event.dateEnd == calendarEventModel.end) &&
            event.title == calendarEventModel.name &&
            calendarEventModel.eventColor ==
                Color(event.calendarEventType.colorDark),
      );
      foundDayEvents.add(eventFound);
    }
    setState(() {
      _foundFilters =
          foundDayEvents.map((e) => e.calendarEventType).toSet().toList();
      _activatedFilters = [..._foundFilters];
      _dayEvents = foundDayEvents;
    });

    print("found day events: $_dayEvents");
    print("found filters: $_foundFilters");
  }

  void _fetchEvents(int month, int year, int? horseId) async {
    setState(() {
      fetchingData = true;
    });
    var events = await Provider.of<CalendarEvents>(context, listen: false)
        .fetchEventsByMonthYear(month, year, horseId);

    _monthEvents = events;
    print("got $events");
    // _events = [];
    setState(() {
      _dayEvents.clear();
      _events.clear();

      _events.addAll(events
          .map((calendarEvent) => CalendarEventModel(
                name: calendarEvent.title,
                begin: calendarEvent.date,
                end: calendarEvent.dateEnd,
                eventColor: Color(calendarEvent.calendarEventType.colorDark),
              ))
          .toList());
    });
    setState(() {
      _calendarController.clearSelected();
      _calendarController.selectedDate = DateTime(year, month, 5);
    });

    setState(() {
      fetchingData = false;
    });
  }

  void _onCalendarPageChanged(int year, int month) {
    setState(() {
      _setTexts(year, month);
      _fetchEvents(month, year, widget.horse?.id);
    });
  }

  /// Set app bar text and month name over calendar.
  void _setTexts(int year, int month) {
    final date = DateTime(year, month);
    _appbarTitle = date.format(kAppBarDateFormat);
    _monthAndYearName = date.format(kMonthFormatWidthYear);
  }

  void _changeCalendarPage({required bool showNext}) => showNext
      ? _calendarController.swipeToNextMonth()
      : _calendarController.swipeToPreviousPage();

  @override
  Widget build(BuildContext context) {
    context.watch<CalendarEvents>().calendarEvents;
    return SingleChildScrollView(
      child: Column(
        children: [
          /// Calendar control row.
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: !fetchingData
                    ? () {
                        _changeCalendarPage(showNext: false);
                      }
                    : null,
              ),
              Text(
                _monthAndYearName,
                style: const TextStyle(
                    fontSize: 16,
                    color: colorPrimaryDark,
                    fontWeight: FontWeight.w600),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: !fetchingData
                    ? () {
                        _changeCalendarPage(showNext: true);
                      }
                    : null,
              ),
            ],
          ),
          AspectRatio(
            aspectRatio: 1 / 1.3,
            child: Stack(
              children: [
                Center(
                  child: fetchingData ? CircularProgressIndicator() : null,
                ),
                CrCalendar(
                  firstDayOfWeek: WeekDay.sunday,
                  eventsTopPadding: 32,
                  initialDate: _currentDate,
                  maxEventLines: 3,
                  controller: _calendarController,
                  forceSixWeek: true,
                  onDayClicked: (events, day) {
                    print(events);
                    _fetchDayEvents(events);
                  },
                  dayItemBuilder: (properties) => DayItemWidget(
                    properties: properties,
                  ),
                  weekDaysBuilder: (day) => WeekDaysWidget(day: day),
                  eventBuilder: (drawer) => EventWidget(drawer: drawer),
                  minDate: DateTime.now().subtract(const Duration(days: 1000)),
                  maxDate: DateTime.now().add(const Duration(days: 180)),
                ),
              ],
            ),
          ),
          InbloSubHeader(
            title: "イベント予定",
            textOnly: true,
            trailing: FutureBuilder(
                future: getHorsesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return InbloTextButton(
                      onPressed: () {
                        showCustomDialog(
                          context: context,
                          title: "状態入力",
                          content: (ctx) => AddEventDialog(
                            horse: widget.horse,
                            onUpdate: () {
                              _fetchEvents(_currentDate.month,
                                  _currentDate.year, widget.horse?.id);
                            },
                          ),
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
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
          // 絞り込み
          if (_dayEvents.isNotEmpty)
            Container(
              width: double.infinity,
              color: colorDarkBackground,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 4, vertical: 14),
                child: Wrap(
                  alignment: WrapAlignment.start,
                  runAlignment: WrapAlignment.spaceBetween,
                  direction: Axis.horizontal,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 12),
                      child: Text(
                        "絞り込み",
                        style: TextStyle(
                          color: colorPrimaryDark,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    for (CalendarEventType filter in _foundFilters)
                      InkWell(
                        onTap: () {
                          setState(() {
                            var index = _activatedFilters
                                .indexWhere((f) => f.name == filter.name);
                            if (index == -1) {
                              _activatedFilters.add(filter);
                            } else {
                              _activatedFilters.removeAt(index);
                            }
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: Color(filter.colorDarker).withOpacity(
                                  _activatedFilters.contains(filter) ? 1 : 0),
                              width: 1,
                            ),
                            color: Color(filter.colorLight),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 16),
                            child: Text(
                              filter.name,
                              style: TextStyle(
                                color: Color(filter.colorDarker),
                                // fontWeight: FontWeight.bold,
                                fontFamily: "Roboto",
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          if (filteredDayEvents.isNotEmpty)
            Container(
              height: filteredDayEvents.length * 110,
              color: Colors.white,
              padding: EdgeInsets.only(top: 12),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                // shrinkWrap: true,
                itemCount: filteredDayEvents.length,
                itemBuilder: (context, index) {
                  return InbloEventTile(
                    calendarEvent: filteredDayEvents[index],
                    onTap: () {
                      showCustomDialog(
                        context: context,
                        title: "",
                        clearHeaders: true,
                        horizontalPadding: 0,
                        containerPadding: 0,
                        content: (ctx) => ViewEventDialog(
                          horse: widget.horse,
                          calendarEvent: filteredDayEvents[index],
                          onUpdate: () {
                            _fetchEvents(_currentDate.month, _currentDate.year,
                                widget.horse?.id);
                          },
                          onDelete: () {
                            _fetchEvents(_currentDate.month, _currentDate.year,
                                widget.horse?.id);
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

/// Widget of day item cell for calendar
class DayItemWidget extends StatelessWidget {
  DayItemWidget({
    required this.properties,
    this.onTap,
    super.key,
  });

  final DayItemProperties properties;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: properties.isSelected
              ? Border.all(color: colorPrimaryDark.withOpacity(1), width: 0.8)
              : Border.all(
                  color: colorPrimaryDark.withOpacity(0.3), width: 0.3)),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 4),
            alignment: Alignment.topCenter,
            child: Container(
              height: 26,
              width: 26,
              decoration: BoxDecoration(
                color: properties.isCurrentDay
                    ? colorPrimaryDark
                    : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text('${properties.dayNumber}',
                    style: TextStyle(
                        color: properties.isCurrentDay
                            ? Colors.white
                            : colorPrimaryDark
                                .withOpacity(properties.isInMonth ? 1 : 0.5))),
              ),
            ),
          ),
          if (properties.notFittedEventsCount > 0)
            Container(
              padding: const EdgeInsets.only(right: 2, top: 2),
              alignment: Alignment.topRight,
              child: Text('+${properties.notFittedEventsCount}',
                  style: TextStyle(
                      fontSize: 10,
                      color: colorPrimaryDark
                          .withOpacity(properties.isInMonth ? 1 : 0.5))),
            ),
        ],
      ),
    );
  }
}

enum JpWeekDay {
  sunday("日"),
  monday("月"),
  tuesday("火"),
  wednesday("水"),
  thursday("木"),
  friday("金"),
  saturday("土");

  final String name;
  const JpWeekDay(this.name);
}

/// Widget that represents week days in row above calendar month view.
class WeekDaysWidget extends StatelessWidget {
  const WeekDaysWidget({
    required this.day,
    super.key,
  });

  /// [WeekDay] value from [WeekDaysBuilder].
  final WeekDay day;

  @override
  Widget build(BuildContext context) {
    var jpWeekday;
    switch (day) {
      case WeekDay.sunday:
        jpWeekday = JpWeekDay.sunday;
        break;
      case WeekDay.monday:
        jpWeekday = JpWeekDay.monday;
        break;
      case WeekDay.tuesday:
        jpWeekday = JpWeekDay.tuesday;
        break;
      case WeekDay.wednesday:
        jpWeekday = JpWeekDay.wednesday;
        break;
      case WeekDay.thursday:
        jpWeekday = JpWeekDay.thursday;
        break;
      case WeekDay.friday:
        jpWeekday = JpWeekDay.friday;
        break;
      case WeekDay.saturday:
        jpWeekday = JpWeekDay.saturday;
        break;
    }
    return Container(
      height: 40,
      child: Center(
        child: Text(
          jpWeekday.name,
          style: TextStyle(
              color: colorPrimaryDark.withOpacity(0.9),
              fontFamily: "Roboto",
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

/// Custom event widget with rounded borders
class EventWidget extends StatelessWidget {
  const EventWidget({
    required this.drawer,
    super.key,
  });

  final EventProperties drawer;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      // padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        color: drawer.backgroundColor,
      ),
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 8),
        child: Text(
          drawer.name,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              color: Colors.white, fontSize: 11, letterSpacing: 1.1),
        ),
      ),
    );
  }
}
