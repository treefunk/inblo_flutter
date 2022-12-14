import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:inblo_app/common_widgets/inblo_outlined_button.dart';
import 'package:inblo_app/constants/app_theme.dart';
import 'package:inblo_app/features/horse_list/providers/persons_in_charge.dart';
import 'package:inblo_app/features/horse_list/providers/horses.dart';
import 'package:inblo_app/models/horse.dart';
import 'package:inblo_app/util/inblo_desktop_scroll_behavior.dart';
import 'package:provider/provider.dart';

class HorseList extends StatefulWidget {
  Function(
    int index,
  ) onHorseTap;

  Function(
    BuildContext context,
    Horse horse,
  ) onEditHorse;

  Function(
    BuildContext context,
    Horse horse,
  ) onArchiveHorse;

  HorseList({
    required this.onHorseTap,
    required this.onEditHorse,
    required this.onArchiveHorse,
    Key? key,
  }) : super(key: key);

  @override
  State<HorseList> createState() => _HorseListState();
}

class _HorseListState extends State<HorseList> {
  late final Future fetchHorsesFuture;

  @override
  void initState() {
    fetchHorsesFuture =
        Provider.of<Horses>(context, listen: false).fetchHorses();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchHorsesFuture,
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
              var horses = context.watch<Horses>().horses;
              return Expanded(
                  child: ScrollConfiguration(
                behavior: InbloDesktopScrollBehavior(),
                child: ListView.builder(
                  itemCount: horses.length,
                  itemBuilder: (context, index) => Slidable(
                    endActionPane: ActionPane(
                        motion: ScrollMotion(),
                        extentRatio: 0.20,
                        children: [
                          SlidableAction(
                            onPressed: (ctx) =>
                                widget.onArchiveHorse(ctx, horses[index]),
                            backgroundColor: colorPrimaryDark,
                            icon: Icons.archive,
                          )
                        ]),
                    child: Ink(
                      decoration: BoxDecoration(
                        border: null,
                        // _highlightedIndex == index
                        //     ? Border.symmetric(
                        //         horizontal: BorderSide(
                        //           width: 1,
                        //           color: colorPrimaryDark,
                        //         ),
                        //       )
                        //     : null
                      ),
                      child: InkWell(
                        splashColor: colorPrimary,
                        onHighlightChanged: (highlighted) {
                          // if (highlighted) {
                          //   setState(() {
                          //     _highlightedIndex = index;
                          //   });
                          // } else {
                          //   setState(() {
                          //     _highlightedIndex = -1;
                          //   });
                          // }
                        },
                        onTap: () {
                          print("ontap $index");
                          // context.beamToNamed("/horse/$index");
                          widget.onHorseTap(index);
                        },
                        child: ListTile(
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
                            onPressed: () {
                              widget.onEditHorse(context, horses[index]);
                            },
                            title: "内容修正",
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ));
            }
          }
        });
  }
}
