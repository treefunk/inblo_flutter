import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_web_frame/flutter_web_frame.dart';

import 'package:inblo_app/features/auth/providers/auth.dart';
import 'package:inblo_app/features/horse_list/providers/persons_in_charge.dart';
import 'package:inblo_app/features/horse_list/providers/horses.dart';
import 'package:inblo_app/features/messages/provider/messages.dart';
import 'package:inblo_app/features/tab_daily_reports/providers/daily_reports.dart';
import 'package:inblo_app/features/tab_treatments/providers/treatments.dart';
import 'package:inblo_app/home_screen.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import './constants/app_theme.dart' as app_theme;
import 'features/calendar/provider/calendar_events.dart';

void main() async {
  setupEnv();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await initializeDateFormatting();

  runApp(const MyApp());
}

const Set<PointerDeviceKind> _kTouchLikeDeviceTypes = <PointerDeviceKind>{
  PointerDeviceKind.touch,
  PointerDeviceKind.mouse,
  PointerDeviceKind.stylus,
  PointerDeviceKind.invertedStylus,
  PointerDeviceKind.unknown
};

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
          create: (ctx) => Users(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CalendarEvents(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Horses(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Messages(),
        ),
        ChangeNotifierProxyProvider<Horses, DailyReports>(
          create: (context) => DailyReports(null),
          update: (context, horses, previousDailyReports) {
            DailyReports drProvider = DailyReports(horses.selectedHorse);
            drProvider
                .setDailyReports(previousDailyReports?.dailyReports ?? []);
            return drProvider;
          },
        ),
        ChangeNotifierProxyProvider<Horses, Treatments>(
          create: (context) => Treatments(null),
          update: (context, horses, previousTreatments) {
            Treatments trProvider = Treatments(horses.selectedHorse);
            trProvider.setTreatments(previousTreatments?.treatments ?? []);
            return trProvider;
          },
        )
      ],
      // child: MaterialApp(
      //   title: 'Inblo',
      //   theme: app_theme.themeData,
      //   home: HomeScreen(),
      // ),
      child: FlutterWebFrame(
        maximumSize: Size(500, 812),
        builder: (ctx) => MaterialApp(
          scrollBehavior: const MaterialScrollBehavior()
              .copyWith(scrollbars: true, dragDevices: _kTouchLikeDeviceTypes),
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
