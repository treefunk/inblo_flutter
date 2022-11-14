import 'package:flutter/material.dart';
import 'package:inblo_app/constants/app_theme.dart';

class TableColumnLabel extends StatelessWidget {
  final String title;
  final double extraWidth;

  const TableColumnLabel({
    required this.title,
    this.extraWidth = 0.0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100 + extraWidth,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: "Roboto",
          fontSize: 12,
          color: Colors.white,
        ),
      ),
    );
  }
}

class TableValueLabel extends StatelessWidget {
  final String title;
  final double extraWidth;
  final double width;

  const TableValueLabel({
    required this.title,
    this.extraWidth = 0.0,
    this.width = 100,
    Key? key,
  }) : super(key: key);

  const TableValueLabel.onlyWidth(this.width)
      : title = "",
        extraWidth = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width + extraWidth,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: "Roboto",
          fontSize: 12,
          color: colorPrimaryDark,
        ),
      ),
    );
  }
}
