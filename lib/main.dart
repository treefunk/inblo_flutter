import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inblo_app/features/auth/presentation/sign_in_screen.dart';
import 'package:inblo_app/features/dashboard/presentation/main_dashboard_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import './constants/app_theme.dart' as app_theme;

void main() {
  setupEnv();
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
      title: 'Inblo',
      theme: app_theme.themeData,
      home: SignInScreen(),
    );
  }
}

enum AppMode {
  production,
  staging;

  static AppMode fromString(String mode) {
    if (mode == "production") {
      return AppMode.production;
    }
    if (mode == "staging") {
      return AppMode.staging;
    }
    throw Exception("Mode not supported!");
  }
}

void setupEnv() async {
  try {
    DotEnv mainEnv = DotEnv();
    await mainEnv.load(fileName: ".env");
    AppMode appMode = AppMode.fromString(mainEnv.get("app_mode"));
    String envFileName;
    switch (appMode) {
      case AppMode.production:
        envFileName = ".env.production";
        break;
      case AppMode.staging:
        envFileName = ".env.staging";
        break;
    }
    await dotenv.load(fileName: envFileName);
  } catch (exception) {
    print(exception);
  }
}
