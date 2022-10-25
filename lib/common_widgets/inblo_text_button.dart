import 'package:flutter/material.dart';
import 'package:inblo_app/constants/app_theme.dart';

class InbloTextButton extends StatefulWidget {
  final String title;
  final void Function() onPressed;

  const InbloTextButton({
    required this.onPressed,
    required this.title,
  });

  @override
  State<InbloTextButton> createState() => _InbloTextButtonState();
}

class _InbloTextButtonState extends State<InbloTextButton> {
  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xFF1E47D3),
            offset: Offset(0, 5),
          ),
        ],
        border: Border.all(color: Color(0xFF328ED1), width: 1),
        color: Color(0xFF2B57EA),
        borderRadius: BorderRadius.circular(28),
      ),
      child: InkWell(
        splashColor: themeData.colorScheme.primary,
        borderRadius: BorderRadius.circular(28),
        onTap: () {},
        child: Container(
          padding: EdgeInsets.all(10),
          width: double.infinity,
          alignment: Alignment.center,
          child: Text(
            widget.title,
            style: TextStyle(
              fontFamily: "Hiragino",
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
