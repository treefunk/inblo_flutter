import 'package:flutter/material.dart';
import 'package:inblo_app/constants/app_theme.dart';

class InbloOutlinedButton extends StatelessWidget {
  Function() onPressed;
  String title;

  InbloOutlinedButton({
    required this.onPressed,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      // style: ButtonStyle()
      style: OutlinedButton.styleFrom(
          padding: EdgeInsets.all(0),
          side: BorderSide(
            width: 1,
            color: colorPrimaryDark,
            style: BorderStyle.solid,
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(7))),
      child: Text(
        title,
        style: TextStyle(
            fontFamily: "Hiragino", fontSize: 10, color: colorPrimaryDark),
      ),
    );
  }
}
