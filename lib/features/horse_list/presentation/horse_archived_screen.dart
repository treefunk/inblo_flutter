import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inblo_app/common_widgets/general_dialog.dart';
import 'package:inblo_app/common_widgets/inblo_sub_header.dart';
import 'package:inblo_app/common_widgets/inblo_text_button.dart';
import 'package:inblo_app/features/horse_list/presentation/widgets/horse_archived_list.dart';
import 'package:inblo_app/features/horse_list/providers/horses.dart';
import 'package:provider/provider.dart';

class HorseArchivedScreen extends StatefulWidget {
  const HorseArchivedScreen({super.key});

  @override
  State<HorseArchivedScreen> createState() => _HorseArchivedScreenState();
}

class _HorseArchivedScreenState extends State<HorseArchivedScreen> {
  void restoreHorse(int horseId) async {
    if (await showConfirmationDialog(context, "Restore Horse",
        "Are you sure you want to restore this horse?")) {
      context.read<Horses>().restoreArchivedHorse(horseId);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      InbloSubHeader(
          title: "馬のアーカイブ",
          trailing: InbloTextButton(
            onPressed: () {
              context.go("/horse-list");
            },
            title: "リストに戻る",
            padding: 0,
            textStyle: TextStyleInbloButton.medium,
            iconPrefix: Icon(
              Icons.arrow_back,
              size: 18,
              color: Colors.white,
            ),
          )),
      HorseArchivedList(
        onItemTap: (id) {
          // Navigator.of(context).push(MaterialPageRoute(
          //     builder: ((context) => HorseDetailsScreen(index))));
          print("attempting to restore id: ${id}");
          restoreHorse(id);
        },
      )
    ]);
  }
}
