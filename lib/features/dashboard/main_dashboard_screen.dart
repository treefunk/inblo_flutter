import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/parser.dart';

import 'package:inblo_app/constants/app_theme.dart';
import 'package:inblo_app/features/auth/presentation/sign_in_screen.dart';
import 'package:inblo_app/features/auth/presentation/sign_up_screen.dart';
import 'package:inblo_app/features/dashboard/widgets/inblo_app_bar.dart';
import 'package:inblo_app/features/dashboard/widgets/side_navigation_drawer.dart';

// import '../auth/presentation/sign_up_screen.dart';

class MainDashboardScreen extends StatefulWidget {
  MainDashboardScreen({super.key});

  @override
  State<MainDashboardScreen> createState() => _MainDashboardScreenState();
}

class _MainDashboardScreenState extends State<MainDashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  late List<Map<String, Object>> _pages;

  late int _selectedPageIndex;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    _selectedPageIndex = 0;
    _pages = [
      {
        'page': SignInScreen(),
        'title': 'Categories',
      },
      {
        'page': SignUpScreen(),
        'title': 'Favorites',
      },
      {
        'page': SignUpScreen(),
        'title': 'Favorites',
      }
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: _pages[_selectedPageIndex]['page'] as Widget,
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
