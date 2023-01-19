import 'package:flutter/material.dart';

import 'package:inblo_app/constants/app_theme.dart';
import 'package:inblo_app/models/calendar_event.dart';

import 'package:inblo_app/constants/my_ext.dart';

class InbloEventTile extends StatelessWidget {
  InbloEventTile({required this.calendarEvent, required this.onTap});

  final CalendarEvent calendarEvent;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      margin: EdgeInsets.only(bottom: 8, left: 12, right: 12),
      child: Card(
        elevation: 24,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: Color(calendarEvent.calendarEventType.colorDarker),
              width: 10,
            ),
            Container(
              alignment: Alignment.center,
              height: double.infinity,
              color: Color(calendarEvent.calendarEventType.colorLight),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Text(
                  calendarEvent.date.format("MM/dd"),
                  style: TextStyle(
                    color: colorPrimaryDark,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Roboto",
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Column(
                    // mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          calendarEvent.title,
                          style: TextStyle(
                            color: colorPrimaryDark,
                            // fontWeight: FontWeight.bold,
                            fontFamily: "Roboto",
                            fontSize: 18,
                            letterSpacing: 1.1,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                      if (calendarEvent.horse != null)
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                  radius: 8,
                                  backgroundColor: Color(0xFF22D143)),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                calendarEvent.horse?.name ?? "",
                                style: TextStyle(
                                  color: colorPrimaryDark,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Roboto",
                                  fontSize: 17,
                                  letterSpacing: 1.1,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ]),
              ),
            ),
            InkWell(
              onTap: onTap,
              child: Container(
                margin: EdgeInsets.only(right: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Color(calendarEvent.calendarEventType.colorDark),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  child: Text(
                    "見る",
                    style: TextStyle(
                      color: Colors.white,
                      // fontWeight: FontWeight.bold,
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
    );
  }
}
