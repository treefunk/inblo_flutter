import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:inblo_app/common_widgets/inblo_text_button.dart';
import 'package:inblo_app/constants/app_theme.dart';

class HorseListScreen extends StatelessWidget {
  const HorseListScreen({super.key});

  void showCustomDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,

      // barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) {
        return LayoutBuilder(
          builder: (p0, p1) => Center(
            child: SingleChildScrollView(
              child: Container(
                  // height: 1000,
                  margin: EdgeInsets.symmetric(horizontal: 24, vertical: 34),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Container(
                        height: 3000,
                        color: Colors.amberAccent,
                      )
                    ],
                  )),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      DarkHeaderWithButton(
        onPressedButton: showCustomDialog,
      ),
      Expanded(
          child: ListView.builder(
        itemCount: 1000,
        itemBuilder: (context, index) => Slidable(
          endActionPane:
              ActionPane(motion: ScrollMotion(), extentRatio: 0.20, children: [
            SlidableAction(
              onPressed: (ctx) {},
              backgroundColor: colorPrimaryDark,
              icon: Icons.archive,
            )
          ]),
          child: ListTile(
            title: Text(
              "${index + 1}. グランモール",
              style: TextStyle(
                fontFamily: "Roboto",
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: colorPrimaryDark,
              ),
            ),
            contentPadding: EdgeInsets.all(16),
            trailing: OutlinedButton(
              onPressed: () {},
              // style: ButtonStyle()
              style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    width: 1,
                    color: colorPrimaryDark,
                    style: BorderStyle.solid,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7))),
              child: Text(
                "内容修正",
                style: TextStyle(
                    fontFamily: "Hiragino",
                    fontSize: 10,
                    color: colorPrimaryDark),
              ),
            ),
          ),
        ),
      ))
    ]);
  }
}

class DarkHeaderWithButton extends StatelessWidget {
  Function? onPressedButton;

  DarkHeaderWithButton({
    this.onPressedButton,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: colorPrimaryDark,
      height: 60,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 14),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Expanded(
            child: Row(
              children: [
                Text(
                  "管理馬一覧",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                SvgPicture.asset("assets/svg/ic-horse.svg")
              ],
            ),
          ),
          Expanded(
              child: Material(
            type: MaterialType.transparency,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 14),
              child: Padding(
                padding: const EdgeInsets.only(left: 50.0),
                child: InbloTextButton(
                  onPressed: () {
                    if (onPressedButton != null) {
                      onPressedButton!(context);
                    }
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
            ),
          ))
        ]),
      ),
    );
  }
}
