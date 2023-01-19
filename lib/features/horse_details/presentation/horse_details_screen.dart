import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inblo_app/common_widgets/general_dialog.dart';
import 'package:inblo_app/constants/app_theme.dart';
import 'package:inblo_app/features/calendar/presentation/calendar_screen.dart';
import 'package:inblo_app/features/horse_details/presentation/view_horse_dialog.dart';
import 'package:inblo_app/features/horse_list/presentation/add_horse_dialog.dart';
import 'package:inblo_app/features/horse_list/providers/horses.dart';
import 'package:inblo_app/features/tab_daily_reports/presentation/daily_reports_screen.dart';
import 'package:inblo_app/features/tab_treatments/presentation/treatments_screen.dart';
import 'package:inblo_app/models/horse.dart';
import 'package:provider/provider.dart';

import 'widgets/header_with_back_btn.dart';
import 'widgets/horse_details_card.dart';

class HorseDetailsScreen extends StatefulWidget {
  // final Horse? horse;
  // const HorseDetailsScreen(this.horse);
  const HorseDetailsScreen();

  @override
  State<HorseDetailsScreen> createState() => _HorseDetailsScreenState();
}

class _HorseDetailsScreenState extends State<HorseDetailsScreen> {
  late List<Map<String, Object>> _detailPages;

  int _selectedDetailPageIndex = 0;

  @override
  void initState() {
    super.initState();
    // print("index: ${horse}");
  }

  @override
  Widget build(BuildContext context) {
    Horse horse = context.watch<Horses>().selectedHorse;

    List<Widget> contentTabs = [
      DailyReportsScreen(),
      TreatmentsScreen(),
      CalendarScreen(
        horse: horse,
      )
    ];

    return Material(
      type: MaterialType.transparency,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        color: colorDarkBackground,
        child: Column(
          children: [
            HeaderWithBackBtn(),
            HorseDetailsCard(
              horseName: horse.name ?? "",
              horseGenderAge: horse.getGenderAndAge,
              onEditHorse: () {
                if (horse != null) {
                  showCustomDialog(
                    context: context,
                    title: "管理馬の詳細",
                    content: (ctx) => AddHorseDialog(ctx, horse: horse),
                  );
                }
              },
              onViewHorse: () {
                if (horse != null) {
                  showCustomDialog(
                    context: context,
                    title: "管理馬の詳細",
                    content: (ctx) => ViewHorseDialog(horse: horse!),
                  );
                }
              },
            ),
            Column(
              children: [
                DefaultTabController(
                  length: 3,
                  child: Container(
                    height: 65,
                    color: Colors.white,
                    child: TabBar(
                      labelColor: colorPrimary,
                      indicatorColor: colorPrimary,
                      unselectedLabelColor: Colors.black26,
                      labelStyle: TextStyle(fontFamily: "Roboto"),
                      onTap: (value) {
                        setState(() {
                          _selectedDetailPageIndex = value;
                        });
                      },
                      tabs: [
                        Tab(
                          icon: _selectedDetailPageIndex == 0
                              ? SvgPicture.asset(
                                  "assets/svg/ic-condition-active.svg")
                              : SvgPicture.asset("assets/svg/ic-condition.svg"),
                          text: "日報",
                        ),
                        Tab(
                          icon: _selectedDetailPageIndex == 1
                              ? SvgPicture.asset(
                                  "assets/svg/ic-treatment-active.svg")
                              : SvgPicture.asset("assets/svg/ic-treatment.svg"),
                          text: "健康管理",
                        ),
                        Tab(
                          icon: _selectedDetailPageIndex == 2
                              ? SvgPicture.asset(
                                  "assets/svg/ic-calendar-active.svg")
                              : SvgPicture.asset("assets/svg/ic-calendar.svg"),
                          text: "カレンダー",
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: contentTabs[_selectedDetailPageIndex],
            )
          ],
        ),
      ),
    );
  }
}


//  @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         color: colorDarkBackground,
//         child: Column(
//           children: [
//             HeaderWithBackBtn(),
//             HorseDetailsCard(),
//             Column(
//               children: [
//                 DefaultTabController(
//                   length: 3,
//                   child: Container(
//                     height: 65,
//                     color: Colors.white,
//                     child: TabBar(
//                       labelColor: colorPrimary,
//                       indicatorColor: colorPrimary,
//                       unselectedLabelColor: Colors.black26,
//                       labelStyle: TextStyle(fontFamily: "Roboto"),
//                       onTap: (value) {
//                         setState(() {
//                           _selectedDetailPageIndex = value;
//                         });
//                       },
//                       tabs: [
//                         Tab(
//                           icon: _selectedDetailPageIndex == 0
//                               ? SvgPicture.asset(
//                                   "assets/svg/ic-condition-active.svg")
//                               : SvgPicture.asset("assets/svg/ic-condition.svg"),
//                           text: "日報",
//                         ),
//                         Tab(
//                           icon: _selectedDetailPageIndex == 1
//                               ? SvgPicture.asset(
//                                   "assets/svg/ic-treatment-active.svg")
//                               : SvgPicture.asset("assets/svg/ic-treatment.svg"),
//                           text: "健康管理",
//                         ),
//                         Tab(
//                           icon: _selectedDetailPageIndex == 2
//                               ? SvgPicture.asset(
//                                   "assets/svg/ic-calendar-active.svg")
//                               : SvgPicture.asset("assets/svg/ic-calendar.svg"),
//                           text: "カレンダー",
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Expanded(
//               child: IndexedStack(index: _selectedDetailPageIndex, children: [
//                 DailyReportsScreen(),
//                 TreatmentsScreen(),
//                 CalendarScreen(),
//               ]),
//             )
//           ],
//         ),
//       ),
//       appBar: InbloAppBar(scaffoldKey: _scaffoldKey),
//       endDrawer: SideNavigationDrawer(),
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: Colors.white,
//         unselectedItemColor: colorPrimaryDark,
//         selectedItemColor: colorPrimaryDark,
//         type: BottomNavigationBarType.fixed,
//         selectedFontSize: 12,
//         unselectedFontSize: 12,
//         items: [
//           BottomNavigationBarItem(
//             backgroundColor: Theme.of(context).colorScheme.primary,
//             icon: SvgPicture.asset(
//               "assets/svg/calendar.svg",
//               width: 20,
//               height: 20,
//             ),
//             label: 'カレンダー',
//           ),
//           BottomNavigationBarItem(
//             backgroundColor: Theme.of(context).colorScheme.primary,
//             icon: SvgPicture.asset(
//               "assets/svg/horse-list.svg",
//               width: 20,
//               height: 20,
//             ),
//             label: '管理馬一覧',
//           ),
//           BottomNavigationBarItem(
//             backgroundColor: Theme.of(context).colorScheme.primary,
//             icon: SvgPicture.asset(
//               "assets/svg/messages.svg",
//               width: 20,
//               height: 20,
//             ),
//             label: 'メッセージ',
//           )
//         ],
//         onTap: ((value) {
//           Navigator.of(context).pop(value);
//           // Navigator.of(context).pushReplacement(
//           //   MaterialPageRoute(
//           //     builder: ((ctx) {
//           //       return MainDashboardScreen(
//           //           preSelectedTab: DashboardTab.createFromInt(value));
//           //     }),
//           //   ),
//           // );
//         }),
//       ),
//     );