import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_web_frame/flutter_web_frame.dart';

import 'package:inblo_app/features/auth/providers/auth.dart';
import 'package:inblo_app/features/horse_list/providers/persons_in_charge.dart';
import 'package:inblo_app/features/horse_list/providers/horses.dart';
import 'package:inblo_app/features/tab_daily_reports/providers/daily_reports.dart';
import 'package:inblo_app/home_screen.dart';
import 'package:provider/provider.dart';

import './constants/app_theme.dart' as app_theme;

void main() async {
  setupEnv();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => PersonsInCharge(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Horses(),
        ),
        ChangeNotifierProxyProvider<Horses, DailyReports>(
          create: (context) => DailyReports(null),
          update: (context, horses, previousDailyReports) =>
              DailyReports(horses.selectedHorse),
        )
      ],
      child: FlutterWebFrame(
        maximumSize: Size(424, 812),
        builder: (ctx) => MaterialApp(
          title: 'Inblo',
          theme: app_theme.themeData,
          home: HomeScreen(),
        ),
      ),
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
