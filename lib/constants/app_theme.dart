import 'package:flutter/material.dart';

const colorPrimary = Color(0xFF3E5EC6);
const colorPrimaryDark = Color(0xFF202842);

const colorDarkBackground = Color(0xFFC9CFD8);

const bigButtonColor = Color(0xFF2B57EA);

const colorAgeBackground = Color(0xFF9B4F1D);

final themeData = ThemeData(
  primaryColor: colorPrimary,
  fontFamily: "Roboto",
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(color: Colors.black),
    hintStyle: TextStyle(color: Color(0xFFA8A8A8)),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Color(0xFF2B57EA),
  ),
);


// InputDecoration getDefaultInputDecoration(BuildContext context) {
//   return 
// }
