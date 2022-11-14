// import 'package:flutter/material.dart';
// import 'package:inblo_app/features/horse_list/presentation/widgets/horse_list.dart';

// class HorseListRouter extends StatelessWidget {
//   const HorseListRouter({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       routerDelegate:
//           HorseListRouterDelegate(navigatorKey: GlobalKey<NavigatorState>()),
//       routeInformationParser: HorseListRouteInformationParser(),
//     );
//   }
// }

// class HorseListRoutePath {
//   final int? id;
//   final bool isUnknown;

//   HorseListRoutePath.list()
//       : id = null,
//         isUnknown = false;

//   HorseListRoutePath.details(this.id) : isUnknown = false;

//   HorseListRoutePath.unknown()
//       : id = null,
//         isUnknown = true;

//   bool getIsListPage() => id == null;

//   bool getIsDetailsPage() => id != null;
// }

// class HorseListRouteInformationParser
//     extends RouteInformationParser<HorseListRoutePath> {
//   @override
//   Future<HorseListRoutePath> parseRouteInformation(
//       RouteInformation routeInformation) async {
//     final uri = Uri.parse(routeInformation.location ?? "/");

//     if (uri.pathSegments.length == 0) {
//       return HorseListRoutePath.list();
//     }

//     if (uri.pathSegments.length == 2) {
//       if (uri.pathSegments[0] != 'horse') return HorseListRoutePath.unknown();
//       var remaining = uri.pathSegments[1];
//       var id = int.tryParse(remaining);
//       if (id == null) return HorseListRoutePath.unknown();
//       return HorseListRoutePath.details(id);
//     }

//     return HorseListRoutePath.unknown();
//   }

//   @override
//   RouteInformation? restoreRouteInformation(
//       HorseListRoutePath horseListRoutePath) {
//     // TODO: implement restoreRouteInformation
//     if (horseListRoutePath.isUnknown) {
//       return RouteInformation(location: "/404");
//     }
//     if (horseListRoutePath.getIsDetailsPage()) {
//       return RouteInformation(location: '/horse/${horseListRoutePath.id}');
//     }
//     return RouteInformation(location: "/");
//   }
// }

// class HorseListRouterDelegate extends RouterDelegate<HorseListRoutePath> {
//   final GlobalKey<NavigatorState> navigatorKey;

//   HorseListRouterDelegate({required this.navigatorKey});

//   int? _selectedId;
//   bool _show404 = false;

//   HorseListRoutePath get getCurrentConfiguration {
//     if (_show404) {
//       return HorseListRoutePath.unknown();
//     }

//     return _selectedId == null
//         ? HorseListRoutePath.list()
//         : HorseListRoutePath.details(_selectedId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     _onPopPage(Route route, dynamic result) {
//       if (!route.didPop(result)) {
//         return false;
//       }

//       _selectedId = null;
//       _show404 = false;
//       return true;
//     }

//     _selectedId = 1;

//     return Navigator(
//       key: navigatorKey,
//       pages: [
//         MaterialPage(
//             child: HorseList(
//           onItemTap: (index) {},
//         )),
//         if (_show404)
//           MaterialPage(child: Center(child: Text("404")))
//         else if (_selectedId != null)
//           MaterialPage(child: HorseList(
//             onItemTap: (index) {
//               _selectedId = index;
//             },
//           ))

//         // MaterialPage()
//       ],
//       onPopPage: _onPopPage,
//     );
//   }

//   @override
//   void addListener(VoidCallback listener) {}

//   @override
//   void removeListener(VoidCallback listener) {}

//   @override
//   Future<bool> popRoute() async {
//     return true;
//   }

//   @override
//   Future<void> setNewRoutePath(HorseListRoutePath horseListRoutePath) async {
//     if (horseListRoutePath.isUnknown) {
//       _selectedId = null;
//       _show404 = true;
//     }

//     if (horseListRoutePath.getIsDetailsPage() &&
//         horseListRoutePath.id != null) {
//       _selectedId = horseListRoutePath.id;
//     } else {
//       _selectedId = null;
//     }

//     _show404 = false;
//   }
// }
