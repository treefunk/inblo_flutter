// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

// import 'package:flutter/material.dart';
// import 'package:beamer/beamer.dart';
// import 'package:inblo_app/features/horse_details/presentation/horse_details_screen.dart';
// import 'package:inblo_app/features/horse_list/presentation/widgets/horse_list.dart';

// class HorseListBeamer extends StatelessWidget {
//   HorseListBeamer({super.key});

//   final _beamerKey = GlobalKey<BeamerState>();
//   final _routerDelegate = BeamerDelegate(
//       locationBuilder: BeamerLocationBuilder(beamLocations: [HorseLocation()]));

//   @override
//   Widget build(BuildContext context) {
//     return Beamer();
//   }
// }

// class HorseLocation extends BeamLocation<BeamState> {
//   @override
//   List<Pattern> get pathPatterns => ['/horse/:horseId'];

//   @override
//   List<BeamPage> buildPages(BuildContext context, BeamState state) => [
//         BeamPage(
//             key: ValueKey("horses"),
//             title: "horses",
//             type: BeamPageType.noTransition,
//             child: HorseList()),
//         if (state.pathParameters.containsKey('horseId'))
//           BeamPage(
//             key: ValueKey("horse-${state.pathParameters["horseId"]}"),
//             child:
//                 HorseDetailsScreen(int.parse(state.pathParameters["horseId"]!)),
//           )
//       ];
// }
