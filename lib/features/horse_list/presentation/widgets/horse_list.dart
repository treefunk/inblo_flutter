import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:inblo_app/constants/app_theme.dart';

class HorseList extends StatelessWidget {
  const HorseList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
    ));
  }
}
