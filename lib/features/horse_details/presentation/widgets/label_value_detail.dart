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
      alignment: Alignment.center,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            label,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontFamily: "Roboto",
              fontSize: 14,
              color: colorPrimary,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                value,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: colorPrimaryDark,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
