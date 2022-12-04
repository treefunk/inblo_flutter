import 'package:flutter/material.dart';
import 'package:inblo_app/common_widgets/inblo_outlined_button.dart';
import 'package:inblo_app/constants/app_theme.dart';
import 'package:inblo_app/features/horse_list/providers/horses.dart';
import 'package:provider/provider.dart';

class HorseArchivedList extends StatefulWidget {
  Function(
    int horseId,
  ) onItemTap;

  HorseArchivedList({
    required this.onItemTap,
    Key? key,
  }) : super(key: key);

  @override
  State<HorseArchivedList> createState() => _HorseArchivedListState();
}

class _HorseArchivedListState extends State<HorseArchivedList> {
  late Future getArchivedHorsesFuture;

  @override
  void initState() {
    getArchivedHorsesFuture = context.read<Horses>().fetchArchivedHorses();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getArchivedHorsesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            if (snapshot.error != null) {
              return Expanded(
                child: Center(
                  child: Text("Something went wrong. Please try again."),
                ),
              );
            } else {
              var horses = context.watch<Horses>().archivedHorses;
              return Expanded(
                  child: ListView.builder(
                itemCount: horses.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(
                    "${index + 1}. ${horses[index].name}",
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: colorPrimaryDark,
                    ),
                  ),
                  contentPadding: EdgeInsets.all(16),
                  trailing: InbloOutlinedButton(
                    onPressed: () => widget.onItemTap(horses[index].id!),
                    title: "戻す",
                  ),
                ),
              ));
            }
          }
        });
  }
}
