import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inblo_app/common_widgets/inblo_text_button.dart';

import '../constants/app_theme.dart';

class InbloSubHeader extends StatelessWidget {
  String title;
  Widget? trailing;

  InbloSubHeader({
    required this.title,
    this.trailing,
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
                  title,
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
                  padding: const EdgeInsets.only(left: 50.0), child: trailing),
            ),
          ))
        ]),
      ),
    );
  }
}

// InbloTextButton(
//                   onPressed: () {
//                     if (onPressedButton != null) {
//                       onPressedButton!(context);
//                     }
//                   },
//                   title: "管理馬の追加",
//                   padding: 0,
//                   textStyle: TextStyleInbloButton.medium,
//                   iconPrefix: Icon(
//                     Icons.add_circle_outline,
//                     size: 18,
//                     color: Colors.white,
//                   ),
//                 ),