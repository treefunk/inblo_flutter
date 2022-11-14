import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inblo_app/constants/app_theme.dart';

class HeaderWithBackBtn extends StatelessWidget {
  const HeaderWithBackBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: colorPrimaryDark,
      height: 60,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Stack(
                      children: [
                        // SvgPicture.asset(
                        //   "assets/svg/ic-close.svg",
                        //   height: 35,
                        //   width: 35,
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.arrow_back,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Spacer(),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "詳細情報",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          SvgPicture.asset("assets/svg/ic-horse.svg")
                        ],
                      ),
                    ),
                    Spacer(),
                    SizedBox(
                      width: 30,
                    )
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
