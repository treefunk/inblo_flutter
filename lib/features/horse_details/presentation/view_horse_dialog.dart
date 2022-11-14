import 'package:flutter/material.dart';
import 'package:inblo_app/features/horse_details/presentation/widgets/label_value_detail.dart';

class ViewHorseDialog extends StatefulWidget {
  const ViewHorseDialog({super.key});

  @override
  State<ViewHorseDialog> createState() => _ViewHorseDialogState();
}

class _ViewHorseDialogState extends State<ViewHorseDialog> {
  final _birthDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 16,
      ),
      LabelValueDetail(
        label: "馬名:",
        value: "馬馬馬馬馬馬馬馬馬", // horse name
      ),
      LabelValueDetail(
        label: "厩舎名:",
        value: "馬馬馬馬馬馬馬馬馬", // stable name
      ),
      LabelValueDetail(
        label: "担当者:",
        value: "馬馬馬馬馬馬馬馬馬", // person in charge
      ),
      LabelValueDetail(
        label: "馬主名:",
        value: "馬馬馬馬馬馬馬馬馬", // owner name
      ),
      LabelValueDetail(
        label: "生産牧場名:",
        value: "馬馬馬馬馬馬馬馬馬", // farm name
      ),
      LabelValueDetail(
        label: "育成場名:",
        value: "馬馬馬馬馬馬馬馬馬", // training farm name
      ),
      LabelValueDetail(
        label: "性齢:",
        value: "馬馬馬馬馬馬馬馬馬", // sexual age
      ),
      LabelValueDetail(
        label: "毛色:",
        value: "馬馬馬馬馬馬馬馬馬", // color
      ),
      LabelValueDetail(
        label: "クラス:",
        value: "馬馬馬馬馬馬馬馬馬", // class
      ),
      LabelValueDetail(
        label: "父:",
        value: "馬馬馬馬馬馬馬馬馬", // father
      ),
      LabelValueDetail(
        label: "母:",
        value: "馬馬馬馬馬馬馬馬馬", // mother
      ),
      LabelValueDetail(
        label: "母父:",
        value: "馬馬馬馬馬馬馬馬馬", // mother / father
      ),
      LabelValueDetail(
        label: "総賞金:",
        value: "馬馬馬馬馬馬馬馬馬", // total stake
      ),
      LabelValueDetail(
        label: "メモ:",
        value: "馬馬馬馬馬馬馬馬馬", // memo
      ),
      SizedBox(
        height: 60,
      )
    ]);
  }
}
