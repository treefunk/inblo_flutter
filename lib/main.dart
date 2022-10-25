import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inblo_app/features/auth/presentation/sign_in_screen.dart';

import './constants/app_theme.dart' as app_theme;

import './common_widgets/inblo_text_field.dart';
import './common_widgets/inblo_text_button.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
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
      home: SignInScreen(),
    );
  }
}
