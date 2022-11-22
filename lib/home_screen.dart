import 'package:flutter/material.dart';
import 'package:inblo_app/features/auth/presentation/sign_in_screen.dart';
import 'package:inblo_app/features/auth/providers/auth.dart';
import 'package:inblo_app/features/dashboard/presentation/main_dashboard_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (context, auth, child) => auth.userDetails != null
          ? MainDashboardScreen()
          : FutureBuilder(
              future: auth.tryAutoLogin(),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Consumer<Auth>(builder: (context, auth, child) {
                    if (auth.userDetails != null) {
                      return MainDashboardScreen();
                    }
                    return SignInScreen();
                  });
                }
                return CircularProgressIndicator();
              }),
            ),
    );
  }
}

// FutureBuilder(
//         future: Provider.of<Auth>(context, listen: false).tryAutoLogin(),
//         builder: ((context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             var isLoggedIn = snapshot.data as bool;

//             return Consumer<Auth>(builder: (context, auth, child) {
//               if (isLoggedIn && auth.userDetails != null) {
//                 return MainDashboardScreen();
//               }
//               return SignInScreen();
//             });
//           }
//           return CircularProgressIndicator();
//         }));


  // @override
  // Widget build(BuildContext context) {
  //   return FutureBuilder(
  //       future: Provider.of<Auth>(context, listen: false).tryAutoLogin(),
  //       builder: ((context, snapshot) {
  //         if (snapshot.connectionState == ConnectionState.done) {
  //           var isLoggedIn = snapshot.data as bool;

  //           return Consumer<Auth>(builder: (context, auth, child) {
  //             if (isLoggedIn && auth.userDetails != null) {
  //               return MainDashboardScreen();
  //             }
  //             return SignInScreen();
  //           });
  //         }
  //         return CircularProgressIndicator();
  //       }));
  // }