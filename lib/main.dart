import 'package:flutter/material.dart';

import './constants/app_theme.dart' as app_theme;

import './common_widgets/inblo_text_field.dart';
import './common_widgets/inblo_text_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: app_theme.themeData,
      home: Scaffold(
        body: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              InbloTextField(
                textHint: "ユーザー名",
              ),
              SizedBox(height: 10),
              InbloTextField(
                textHint: "パスワード",
              ),
              SizedBox(
                height: 10,
              ),
              InbloTextButton(
                onPressed: () {},
                title: "登録",
              )
            ],
          ),
        ),
      ),
    );
  }
}
