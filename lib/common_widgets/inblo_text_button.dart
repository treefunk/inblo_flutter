import 'package:flutter/material.dart';
import 'package:inblo_app/constants/app_theme.dart';
import 'package:inblo_app/constants/text_styles.dart';

enum TextStyleInbloButton { big, medium }

extension ButtonTypeExtension on TextStyleInbloButton {
  TextStyle get getTextStyle {
    switch (this) {
      case TextStyleInbloButton.big:
        return buttonBigTxtStyle;
      case TextStyleInbloButton.medium:
        return buttonMediumTxtStyle;
    }
  }
}

class InbloTextButton extends StatefulWidget {
  final String title;
  final void Function() onPressed;
  final TextStyleInbloButton textStyle;
  final double padding;
  final Icon? iconPrefix;

  const InbloTextButton({
    required this.onPressed,
    required this.title,
    required this.textStyle,
    this.padding = 10,
    this.iconPrefix,
  });

  List<Widget> get buttonChildren {
    List<Widget> data = [];
    if (iconPrefix != null) {
      data.add(iconPrefix!);
      data.add(SizedBox(width: 4));
    }
    data.add(Text(
      title,
      style: textStyle.getTextStyle,
    ));
    return data;
  }

  @override
  State<InbloTextButton> createState() => _InbloTextButtonState();
}

class _InbloTextButtonState extends State<InbloTextButton> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Ink(
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
          onTap: widget.onPressed,
          child: Container(
            padding: EdgeInsets.all(widget.padding),
            width: double.infinity,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: widget.buttonChildren,
            ),
          ),
        ),
      ),
    );
  }
}
