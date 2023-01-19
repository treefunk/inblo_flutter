import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inblo_app/constants/app_theme.dart';
import 'package:inblo_app/features/auth/presentation/sign_in_screen.dart';
import 'package:inblo_app/features/auth/providers/auth.dart';
import 'package:inblo_app/models/user_details.dart';
import 'package:inblo_app/util/preference_utils.dart';

import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SideNavigationDrawer extends StatefulWidget {
  const SideNavigationDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<SideNavigationDrawer> createState() => _SideNavigationDrawerState();
}

class _SideNavigationDrawerState extends State<SideNavigationDrawer> {
  Future<UserDetails> getUserDetails() async {
    return await PreferenceUtils.getUserDetails();
  }

  @override
  void initState() {
    super.initState();
  }

  void logout(Auth auth, NavigatorState navigatorState) async {
    var clearLocalStorage = await auth.logout();
    if (clearLocalStorage) {
      navigatorState.pushReplacement(
        MaterialPageRoute(
          builder: (context) => SignInScreen(),
        ),
      );
    }
  }

  void goToInfoPage() async {
    const url = "https://www.keiba.go.jp/KeibaWeb/DataRoom/DataRoomTop";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      // can't launch url
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 20,
      // width: MediaQuery.of(context).size.width * .70,
      child: Column(
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            AppBar(
              // toolbarHeight: 80,
              backgroundColor: colorPrimary,
              title: ListTile(
                title: Text(
                  context.watch<Auth>().userDetails?.username ?? "",
                  style: TextStyle(
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20),
                ),
                subtitle: Text(
                  context.watch<Auth>().userDetails?.roleText ?? "",
                  style: TextStyle(
                      fontFamily: "Roboto",
                      color: Colors.white70,
                      fontSize: 14),
                ),
                contentPadding: EdgeInsets.all(8),
              ),
              automaticallyImplyLeading: false,
              actions: [Container()],
            ),
            // Divider(),
            ListTile(
              leading: Icon(
                Icons.info,
                color: colorPrimaryDark,
                // size: 30,
              ),
              title: Text('地方競馬情報サイト'),
              onTap: () {
                goToInfoPage();
              },
            ),
            ListTile(
              leading: Icon(
                Icons.archive,
                color: colorPrimaryDark,
                // size: 30,
              ),
              title: Text('馬のアーカイブ'),
              onTap: () {
                context.go("/archived-horses-list");
                Navigator.of(context).pop();
              },
            ),
            Divider(
              endIndent: null,
              indent: null,
              height: 1,
              color: colorPrimaryDark,
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: colorPrimaryDark,
                // size: 30,
              ),
              title: Text('ログアウト'),
              onTap: () => logout(
                Provider.of<Auth>(context, listen: false),
                Navigator.of(context, rootNavigator: true),
              ),
            ),
          ]),
    );
  }
}
