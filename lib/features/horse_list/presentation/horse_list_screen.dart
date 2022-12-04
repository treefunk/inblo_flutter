import 'package:flutter/material.dart';
import 'package:inblo_app/common_widgets/inblo_sub_header.dart';
import 'package:inblo_app/common_widgets/general_dialog.dart';
import 'package:inblo_app/common_widgets/inblo_text_button.dart';

import 'package:go_router/go_router.dart';
import 'package:inblo_app/features/horse_list/presentation/add_horse_dialog.dart';
import 'package:inblo_app/features/horse_list/providers/persons_in_charge.dart';
import 'package:inblo_app/features/horse_list/providers/horses.dart';
import 'package:provider/provider.dart';

import 'widgets/horse_list.dart';

class HorseListScreen extends StatefulWidget {
  const HorseListScreen({super.key});

  @override
  State<HorseListScreen> createState() => _HorseListScreenState();
}

class _HorseListScreenState extends State<HorseListScreen> {
  late final Future getUsersFuture;

  @override
  void initState() {
    getUsersFuture = Provider.of<PersonsInCharge>(context, listen: false)
        .initPersonInCharge();
    super.initState();
  }

  void archiveHorse(int horseId) async {
    if (await showConfirmationDialog(context, "Archive Horse",
        "Are you sure you want to archive this horse?")) {
      context.read<Horses>().archiveHorse(horseId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      InbloSubHeader(
        title: "管理馬一覧",
        trailing: FutureBuilder(
            future: getUsersFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return InbloTextButton(
                  onPressed: () {
                    showCustomDialog(
                      context: context,
                      title: "管理馬の詳細",
                      content: (ctx) => AddHorseDialog(ctx),
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
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
      HorseList(
        onHorseTap: (index) {
          // Navigator.of(context).push(MaterialPageRoute(
          //     builder: ((context) => HorseDetailsScreen(index))));
          Provider.of<Horses>(context, listen: false)
              .setSelectedHorseByIndex(index);
          context.go("/horse-list/details");
        },
        onEditHorse: (context, horse) {
          showCustomDialog(
            context: context,
            title: "管理馬の詳細",
            content: (ctx) => AddHorseDialog(ctx, horse: horse),
          );
        },
        onArchiveHorse: (context, horse) {
          archiveHorse(horse.id!);
        },
      )
    ]);
  }
}
