import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:inblo_app/constants/app_theme.dart';
import 'package:inblo_app/features/calendar/presentation/calendar_screen.dart';
import 'package:inblo_app/features/dashboard/presentation/widgets/inblo_app_bar.dart';
import 'package:inblo_app/features/dashboard/presentation/widgets/side_navigation_drawer.dart';
import 'package:inblo_app/features/horse_details/presentation/horse_details_screen.dart';
import 'package:inblo_app/features/horse_list/presentation/horse_list_screen.dart';
import 'package:inblo_app/features/messages/presentation/messages_screen.dart';

// import '../auth/presentation/sign_up_screen.dart';

// enum DashboardTab {
//   calendar(0),
//   horseList(1),
//   messageList(2);

//   final int pageNum;
//   const DashboardTab(this.pageNum);

//   static DashboardTab createFromInt(int pageNum) {
//     DashboardTab selected = DashboardTab.horseList;
//     if (pageNum == 0) {
//       selected = DashboardTab.calendar;
//     } else if (pageNum == 1) {
//       selected = DashboardTab.horseList;
//     } else if (pageNum == 2) {
//       selected = DashboardTab.messageList;
//     }
//     return selected;
//   }
// }

class InbloBottomNavBarItem extends BottomNavigationBarItem {
  final String location;

  const InbloBottomNavBarItem({
    required this.location,
    required Widget icon,
    required String? label,
  }) : super(
          icon: icon,
          label: label,
        );
}

class MainDashboardScreen extends StatefulWidget {
  MainDashboardScreen();

  @override
  State<MainDashboardScreen> createState() => _MainDashboardScreenState();
}

class _MainDashboardScreenState extends State<MainDashboardScreen> {
  final _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: "_rootNavigator");
  final _shellNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: "_shellNavigator");

  @override
  Widget build(BuildContext context) {
    final tabs = [
      InbloBottomNavBarItem(
        location: "/calendar",
        icon: SvgPicture.asset(
          "assets/svg/calendar.svg",
          width: 20,
          height: 20,
        ),
        label: "カレンダー",
      ),
      InbloBottomNavBarItem(
        location: "/horse-list",
        icon: SvgPicture.asset(
          "assets/svg/horse-list.svg",
          width: 20,
          height: 20,
        ),
        label: '管理馬一覧',
      ),
      InbloBottomNavBarItem(
        location: "/message-list",
        icon: SvgPicture.asset(
          "assets/svg/messages.svg",
          width: 20,
          height: 20,
        ),
        label: 'メッセージ',
      )
    ];

    final goRouter = GoRouter(
      initialLocation: '/horse-list',
      navigatorKey: _rootNavigatorKey,
      routes: [
        ShellRoute(
            navigatorKey: _shellNavigatorKey,
            builder: (context, state, child) {
              return InbloScaffoldWithBottomNav(tabs: tabs, child: child);
            },
            routes: [
              // Calendar
              GoRoute(
                path: "/calendar",
                pageBuilder: (context, state) => NoTransitionPage(
                  child: CalendarScreen(),
                ),
              ),
              // horse-list
              GoRoute(
                  path: "/horse-list",
                  pageBuilder: (context, state) => NoTransitionPage(
                        child: HorseListScreen(),
                      ),
                  routes: [
                    GoRoute(
                      path: "details",
                      builder: (context, state) => const HorseDetailsScreen(1),
                    )
                  ]),
              GoRoute(
                path: "/message-list",
                pageBuilder: (context, state) => NoTransitionPage(
                  child: MessagesScreen(),
                ),
              )
            ])
      ],
    );

    return MaterialApp.router(
      routerConfig: goRouter,
      theme: themeData,
    );
  }
}

class InbloScaffoldWithBottomNav extends StatefulWidget {
  final List<InbloBottomNavBarItem> tabs;
  final Widget child;

  const InbloScaffoldWithBottomNav(
      {super.key, required this.child, required this.tabs});

  @override
  State<InbloScaffoldWithBottomNav> createState() =>
      _InbloScaffoldWithBottomNavState();
}

class _InbloScaffoldWithBottomNavState
    extends State<InbloScaffoldWithBottomNav> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _locationToTabIndex(String location) {
    print(location);
    final index = widget.tabs
        .indexWhere((element) => location.startsWith(element.location));
    return index < 0 ? 1 : index;
  }

  int get _currentIndex => _locationToTabIndex(GoRouter.of(context).location);

  void _onItemTapped(BuildContext contexxt, int tabIndex) {
    if (tabIndex != _currentIndex) {
      context.go(widget.tabs[tabIndex].location);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // body: _pages[_selectedPageIndex]['page'] as Widget,
      body: widget.child,
      appBar: InbloAppBar(scaffoldKey: _scaffoldKey),
      endDrawer: SideNavigationDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        unselectedItemColor: colorPrimaryDark,
        selectedItemColor: colorPrimaryDark,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: widget.tabs,
        onTap: (index) => _onItemTapped(context, index),
      ),
    );
  }
}
