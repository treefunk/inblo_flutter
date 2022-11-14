import 'package:flutter/material.dart';
import 'package:inblo_app/constants/app_theme.dart';

class LabelValueDetail extends StatelessWidget {
  final String label;
  final String value;

  const LabelValueDetail({
    required this.label,
    required this.value,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Roboto",
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: colorPrimaryDark,
                letterSpacing: 1.5,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 15,
                color: colorPrimary,
              ),
            ),
          )
        ],
      ),
    );
  }
}
