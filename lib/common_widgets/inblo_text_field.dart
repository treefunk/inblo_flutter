import 'package:flutter/material.dart';

import '../constants/app_theme.dart';

class InbloTextField extends StatelessWidget {
  String textHint;

  InbloTextField({this.textHint = "ーxーxーxー"});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontFamily: "Hiragino",
      ),
      decoration: InputDecoration(
        labelText: textHint,
        labelStyle: TextStyle(
          color: Color(0xFFA8A8A8),
          fontFamily: "Hiragino",
          letterSpacing: 3,
        ),
        floatingLabelStyle: TextStyle(
          // color: Color(0xFF2F2525),
          color: themeData.primaryColor,
          fontFamily: "Hiragino",
          letterSpacing: 3,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.5,
            color: Theme.of(context).primaryColor,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(width: 2, color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
