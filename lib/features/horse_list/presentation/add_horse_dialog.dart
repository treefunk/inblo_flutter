import 'package:flutter/material.dart';
import 'package:inblo_app/common_widgets/inblo_text_button.dart';
import 'package:inblo_app/common_widgets/inblo_text_field.dart';

class AddHorseDialog extends StatelessWidget {
  const AddHorseDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InbloTextField(
          textHint: "馬名", // horse name
        ),
        SizedBox(height: 12),
        InbloTextField(
          textHint: "担当者", // person in charge
        ),
        SizedBox(height: 12),
        InbloTextField(
          textHint: "馬主名", // owner name
        ),
        SizedBox(height: 12),
        InbloTextField(
          textHint: "生産牧場名", // farm name
        ),
        SizedBox(height: 12),
        InbloTextField(
          textHint: "育成場名", // training farm name
        ),
        SizedBox(height: 12),
        InbloTextField(
          textHint: "生年月日", // birth date
        ),
        SizedBox(height: 12),
        InbloTextField(
          textHint: "性", // sex
        ),
        SizedBox(height: 12),
        InbloTextField(
          textHint: "毛色", // color
        ),
        SizedBox(height: 12),
        InbloTextField(
          textHint: "クラス", // class
        ),
        SizedBox(height: 12),
        InbloTextField(
          textHint: "父", // father
        ),
        SizedBox(height: 12),
        InbloTextField(
          textHint: "母", // mother
        ),
        SizedBox(height: 12),
        InbloTextField(
          textHint: "母父", // mother / father
        ),
        SizedBox(height: 12),
        InbloTextField(
          textHint: "総賞金", // total stake
        ),
        SizedBox(height: 12),
        InbloTextField(
          textHint: "メモを書く...", // notes
          maxLines: 6,
        ),
        SizedBox(
          height: 16,
        ),
        InbloTextButton(
            onPressed: () {
              //todo
            },
            title: "＋ 追加",
            textStyle: TextStyleInbloButton.big)
      ],
    );
  }
}
