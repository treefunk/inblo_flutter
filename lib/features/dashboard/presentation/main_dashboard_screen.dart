import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:inblo_app/constants/app_theme.dart';
import 'package:inblo_app/features/calendar/presentation/calendar_screen.dart';
import 'package:inblo_app/features/dashboard/presentation/widgets/inblo_app_bar.dart';
import 'package:inblo_app/features/dashboard/presentation/widgets/side_navigation_drawer.dart';
import 'package:inblo_app/features/horse_list/presentation/horse_list_screen.dart';
import 'package:inblo_app/features/messages/presentation/messages_screen.dart';

// import '../auth/presentation/sign_up_screen.dart';

enum DashboardTab {
  calendar(0),
  horseList(1),
  messageList(2);

  final int pageNum;
  const DashboardTab(this.pageNum);

  static DashboardTab createFromInt(int pageNum) {
    DashboardTab selected = DashboardTab.horseList;
    if (pageNum == 0) {
      selected = DashboardTab.calendar;
    } else if (pageNum == 1) {
      selected = DashboardTab.horseList;
    } else if (pageNum == 2) {
      selected = DashboardTab.messageList;
    }
    return selected;
  }
}

class MainDashboardScreen extends StatefulWidget {
  DashboardTab preSelectedTab;
  MainDashboardScreen({this.preSelectedTab = DashboardTab.horseList});

  @override
  State<MainDashboardScreen> createState() => _MainDashboardScreenState();
}

class _MainDashboardScreenState extends State<MainDashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late List<Map<String, Object>> _pages;

  late int _selectedPageIndex;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    _selectedPageIndex = widget.preSelectedTab.pageNum;
    _pages = [
      {
        'page': CalendarScreen(),
        'title': 'Calendar',
      },
      {
        'page': HorseListScreen(
          navigatorKey: GlobalKey<NavigatorState>(),
        ),
        'title': 'Horse List',
      },
      {
        'page': MessagesScreen(),
        'title': 'Calendar',
      }
    ];
    // _selectedPageIndex = widget.preSelectedIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // body: _pages[_selectedPageIndex]['page'] as Widget,
      body: IndexedStack(
        index: _selectedPageIndex,
        children: _pages.map((page) => page['page'] as Widget).toList(),
      ),
      appBar: InbloAppBar(scaffoldKey: _scaffoldKey),
      endDrawer: SideNavigationDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        unselectedItemColor: colorPrimaryDark,
        selectedItemColor: colorPrimaryDark,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).colorScheme.primary,
            icon: SvgPicture.asset(
              "assets/svg/calendar.svg",
              width: 20,
              height: 20,
            ),
            label: 'カレンダー',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).colorScheme.primary,
            icon: SvgPicture.asset(
              "assets/svg/horse-list.svg",
              width: 20,
              height: 20,
            ),
            label: '管理馬一覧',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).colorScheme.primary,
            icon: SvgPicture.asset(
              "assets/svg/messages.svg",
              width: 20,
              height: 20,
            ),
            label: 'メッセージ',
          )
        ],
        onTap: _selectPage,
      ),
    );
  }
}
