import 'package:flutter/material.dart';
import 'package:inblo_app/common_widgets/inblo_sub_header.dart';
import 'package:inblo_app/common_widgets/general_dialog.dart';
import 'package:inblo_app/common_widgets/inblo_text_button.dart';
import 'package:inblo_app/features/horse_details/presentation/horse_details_screen.dart';

import 'package:inblo_app/features/horse_list/presentation/add_horse_dialog.dart';

import 'widgets/horse_list.dart';

class HorseListScreen extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const HorseListScreen({required this.navigatorKey, super.key});

  @override
  State<HorseListScreen> createState() => _HorseListScreenState();
}

class _HorseListScreenState extends State<HorseListScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      InbloSubHeader(
        title: "管理馬一覧",
        trailing: InbloTextButton(
          onPressed: () {
            showCustomDialog(
              context: context,
              title: "管理馬の詳細",
              content: AddHorseDialog(),
            );
          },
          title: "管理馬の追加",
          padding: 0,
          textStyle: TextStyleInbloButton.medium,
          iconPrefix: Icon(
            Icons.add_circle_outline,
            size: 18,
            color: Colors.white,
          ),
        ),
      ),
      HorseList(
        onItemTap: (index) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: ((context) => HorseDetailsScreen(index))));
        },
      )
    ]);
  }
}
