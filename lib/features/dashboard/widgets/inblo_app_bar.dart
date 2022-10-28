import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:inblo_app/constants/app_theme.dart';

class InbloAppBar extends StatefulWidget implements PreferredSizeWidget {
  const InbloAppBar({
    Key? key,
    required GlobalKey<ScaffoldState> scaffoldKey,
  })  : _scaffoldKey = scaffoldKey,
        super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  State<InbloAppBar> createState() => _InbloAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(50);
}

class _InbloAppBarState extends State<InbloAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      // toolbarHeight: 55,
      backgroundColor: Colors.white,
      leading: Container(
        margin: EdgeInsets.only(left: 16),
        child: SvgPicture.asset(
          "assets/svg/logo.svg",
          fit: BoxFit.fitWidth,
        ),
      ),
      leadingWidth: 120,
      actions: [
        Ink(
          color: themeData.primaryColor,
          child: InkWell(
            onTap: () {
              if (widget._scaffoldKey.currentState != null) {
                if (!widget._scaffoldKey.currentState!.isDrawerOpen) {
                  widget._scaffoldKey.currentState?.openEndDrawer();
                } else {
                  widget._scaffoldKey.currentState?.closeEndDrawer();
                }
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Icon(Icons.menu, size: 25),
                  ),
                  Text(
                    "MENU",
                    style: TextStyle(fontFamily: "Roboto", fontSize: 8),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
