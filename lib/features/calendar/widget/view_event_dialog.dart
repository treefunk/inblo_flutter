import 'package:flutter/material.dart';
import 'package:inblo_app/common_widgets/general_dialog.dart';
import 'package:inblo_app/constants/app_constants.dart';
import 'package:inblo_app/constants/app_theme.dart';
import 'package:inblo_app/constants/my_ext.dart';
import 'package:inblo_app/features/auth/api/boolean_response.dart';
import 'package:inblo_app/features/calendar/presentation/add_event_dialog.dart';
import 'package:inblo_app/features/calendar/provider/calendar_events.dart';
import 'package:inblo_app/models/calendar_event.dart';
import 'package:inblo_app/models/horse.dart';
import 'package:provider/provider.dart';

class ViewEventDialog extends StatefulWidget {
  ViewEventDialog({
    super.key,
    required this.calendarEvent,
    this.horse,
    this.onUpdate,
    this.onDelete,
  });

  final Horse? horse;
  final CalendarEvent calendarEvent;
  void Function()? onUpdate;
  void Function()? onDelete;

  @override
  State<ViewEventDialog> createState() => _ViewEventDialogState();
}

class _ViewEventDialogState extends State<ViewEventDialog> {
  String _getTimeOrNA(String time) {
    String timeString = "";

    if (time.isNotEmpty) {
      timeString += time;
    } else {
      timeString += "N/A";
    }
    return timeString;
  }

  String _getFormattedTime(String startTime, String endTime) {
    String formattedTime = "";

    return "${_getTimeOrNA(widget.calendarEvent.start)} - ${_getTimeOrNA(widget.calendarEvent.end)}";
  }

  void _onDeleteEvent(BuildContext context) async {
    if (!await showConfirmationDialog(context, "Delete Event",
        "Are you sure you want to remove this event?")) {
      return;
    }

    var calendarEventsProvider =
        Provider.of<CalendarEvents>(context, listen: false);

    BooleanResponse response = await calendarEventsProvider
        .deleteCalendarEvent(widget.calendarEvent.id);
    if (response.data == true) {
      widget.onDelete?.call();
      if (!mounted) return;
      Navigator.of(context, rootNavigator: true).pop();
      await showOkDialog(context, "Success", "Event Successfully removed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // constraints: BoxConstraints(minHeight: 450),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Container(
            height: 65,
            margin: EdgeInsets.symmetric(vertical: 18, horizontal: 12),
            child: Row(
              children: [
                Container(
                  color: Color(
                    widget.calendarEvent.calendarEventType.colorDarker,
                  ),
                  width: 8,
                ),
                SizedBox(
                  width: 24,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      Expanded(
                        child: Text(
                          _getFormattedTime(
                            widget.calendarEvent.start,
                            widget.calendarEvent.end,
                          ),
                          style: TextStyle(
                              color: colorPrimaryDark,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      Text(
                        widget.calendarEvent.date
                            .format(AppConstants.dateOnlyFormatYmd),
                        style: TextStyle(
                          color: colorPrimaryDark,
                          fontFamily: "Roboto",
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      )
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Material(
                  // shape: const CircleBorder(),
                  child: InkWell(
                    // customBorder: const CircleBorder(),
                    onTap: () {
                      showCustomDialog(
                        context: context,
                        title: "状態入力",
                        content: (ctx) => AddEventDialog(
                          horse: widget.horse,
                          calendarEvent: widget.calendarEvent,
                          onUpdate: () {
                            // add event dialog
                            Navigator.of(context, rootNavigator: true).pop();

                            // view event dialog (this)
                            Navigator.of(context, rootNavigator: true).pop();

                            widget.onUpdate?.call();
                          },
                        ),
                      );
                    },
                    child: Icon(
                      Icons.edit_note,
                      size: 40,
                    ),
                  ),
                ),
                SizedBox(width: 4),
                Material(
                  // shape: const CircleBorder(),
                  child: InkWell(
                    // customBorder: const CircleBorder(),
                    onTap: () => _onDeleteEvent(context),
                    child: Icon(
                      Icons.delete,
                      color: Colors.red[900],
                      size: 40,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    // margin: EdgeInsets.only(right: 14),
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(
                          widget.calendarEvent.calendarEventType.colorDarker),
                    ),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "閉じる",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Roboto",
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          constraints: BoxConstraints(minHeight: 100),
          color: Color(0xFFF1F1F1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Text(
              widget.calendarEvent.memo,
              style: TextStyle(
                fontFamily: "Roboto",
                color: colorPrimaryDark,
                fontSize: 18,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 24, bottom: 12),
          alignment: Alignment.bottomRight,
          child: Container(
            margin: EdgeInsets.only(right: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: colorPrimaryDark,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 18),
              child: Text(
                "担当者 : ${widget.calendarEvent.user.username ?? ''}",
                style: TextStyle(
                    color: Colors.white,
                    // fontWeight: FontWeight.bold,
                    fontFamily: "Roboto",
                    fontSize: 16,
                    letterSpacing: 1.05),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        )
      ]),
    );
  }
}
