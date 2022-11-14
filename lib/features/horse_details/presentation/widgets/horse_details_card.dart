import 'package:flutter/material.dart';
import 'package:inblo_app/common_widgets/general_dialog.dart';
import 'package:inblo_app/common_widgets/inblo_outlined_button.dart';
import 'package:inblo_app/constants/app_theme.dart';
import 'package:inblo_app/features/horse_details/presentation/view_horse_dialog.dart';
import 'package:inblo_app/features/horse_list/presentation/add_horse_dialog.dart';

class HorseDetailsCard extends StatelessWidget {
  const HorseDetailsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Row(children: [
          Expanded(
            flex: 3,
            child: Text(
              "マイネルグアンチェ", // horse name
              style: TextStyle(
                  fontFamily: "Hiragino", fontSize: 16, letterSpacing: 1.2),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 1, horizontal: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: colorAgeBackground,
                  ),
                  child: Text(
                    "牡5", // age
                    style:
                        TextStyle(fontFamily: "Hiragino", color: Colors.white),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                  width: 6,
                ),
                Material(
                  child: InkWell(
                      onTap: () {
                        showCustomDialog(
                          context: context,
                          title: "管理馬の詳細",
                          content: AddHorseDialog(),
                        );
                      },
                      child: Icon(
                        Icons.edit,
                        size: 20,
                      )),
                ),
                SizedBox(
                  width: 6,
                ),
                InbloOutlinedButton(
                    onPressed: () {
                      showCustomDialog(
                        context: context,
                        title: "管理馬の詳細",
                        content: ViewHorseDialog(),
                      );
                    },
                    title: "詳細を見る")
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
