import 'package:flutter/material.dart';
import 'package:inblo_app/constants/app_theme.dart';

class AppBottomNavBar extends StatefulWidget {
  AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.items,
    this.onTap,
  });

  int currentIndex;
  List<BottomNavigationBarItem> items;
  void Function(int)? onTap;

  @override
  State<AppBottomNavBar> createState() => _AppBottomNavBarState();
}

class _AppBottomNavBarState extends State<AppBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      unselectedItemColor: colorPrimaryDark,
      selectedItemColor: colorPrimaryDark,
      currentIndex: widget.currentIndex,
      type: BottomNavigationBarType.fixed,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      items: widget.items,
      onTap: widget.onTap,
    );
  }
}
