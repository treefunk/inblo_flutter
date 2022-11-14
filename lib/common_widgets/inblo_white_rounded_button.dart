import 'package:flutter/material.dart';
import 'package:inblo_app/constants/app_theme.dart';

class InbloWhiteRoundedButton extends StatelessWidget {
  Function() onPressed;
  String title;
  IconData? iconPrefix;

  InbloWhiteRoundedButton({
    required this.onPressed,
    required this.title,
    this.iconPrefix,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
        ),
        backgroundColor: MaterialStatePropertyAll(Colors.white),
        foregroundColor: MaterialStatePropertyAll(colorPrimaryDark),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (iconPrefix != null)
            Icon(
              iconPrefix,
              size: 20,
              color: colorPrimary,
            ),
          SizedBox(
            width: 8,
          ),
          Text(
            title,
            style: TextStyle(
                fontFamily: "Roboto",
                fontWeight: FontWeight.bold,
                fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
