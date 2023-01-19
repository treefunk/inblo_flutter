import 'package:flutter/material.dart';
import 'package:inblo_app/constants/app_theme.dart';
import 'package:inblo_app/features/calendar/widget/calcr.dart';
import 'package:inblo_app/features/calendar/widget/inblo_calendar.dart';
import 'package:inblo_app/features/calendar/widget/inblo_calendar_alt.dart';
import 'package:inblo_app/models/horse.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({this.horse, super.key});

  final Horse? horse;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          color: Colors.white,
          child: Column(
            children: [
              if (horse != null) Divider(),
              Calcr(
                horse: horse,
              ),
            ],
          )),
    );
  }
}
