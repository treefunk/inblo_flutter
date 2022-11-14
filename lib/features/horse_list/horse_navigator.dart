// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/material.dart';
// import 'package:inblo_app/features/horse_details/presentation/horse_details_screen.dart';
// import 'package:inblo_app/features/horse_list/presentation/widgets/horse_list.dart';

// class HorseNavigatorRoutes {
//   static const String root = "/";
//   static const String detail = "/detail";
// }

// enum TabItem { horse_list, horse_details }

// class HorseNavigator extends StatelessWidget {
//   final GlobalKey<NavigatorState> navigatorKey;
//   final TabItem tabItem;

//   HorseNavigator({
//     required this.navigatorKey,
//     required this.tabItem,
//   });

//   Map<String, WidgetBuilder> _routeBuilder(BuildContext context, int horseId) {
//     return {
//       HorseNavigatorRoutes.root: (context) => HorseList(onItemTap: ((index) {
//             return _push(context, horseId);
//           })),
//       HorseNavigatorRoutes.detail: ((context) => HorseDetailsScreen(horseId))
//     };
//   }

//   void _push(BuildContext context, int horseId) {
//     var routeBuilders = _routeBuilder(context, horseId);

//     Navigator.push(
//         context,
//         MaterialPageRoute(
//             builder: (context) =>
//                 routeBuilders[HorseNavigatorRoutes.detail]!(context)));
//   }

//   @override
//   Widget build(BuildContext context) {
//     var routeBuilders = _routeBuilder(context, -1);

//     return Navigator(
//       key: navigatorKey,
//       initialRoute: HorseNavigatorRoutes.root,
//       onPopPage: ((route, result) {
//         return false;
//       }),
//       onGenerateRoute: (routeSettings) {
//         return MaterialPageRoute(
//             builder: (context) => routeBuilders[routeSettings.name]!(context));
//       },
//     );
//   }
// }
