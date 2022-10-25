import 'package:flutter/material.dart';

class InbloTextButton extends StatelessWidget {
  final String title;
  final void Function() onPressed;

  const InbloTextButton({
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
            side: BorderSide(color: Color(0xFF328ED1), width: 1),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(
          Color(0xFF2B57EA),
        ),
        foregroundColor: MaterialStateProperty.all(Colors.white),
      ),
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 16,
              letterSpacing: 2.5,
            ),
          ),
        ),
      ),
    );
  }
}
