import 'package:flutter/material.dart';
import 'package:inblo_app/constants/app_theme.dart';
import 'package:inblo_app/features/horse_details/presentation/widgets/label_value_detail.dart';
import 'package:inblo_app/models/horse.dart';

class ViewHorseDialog extends StatelessWidget {
  const ViewHorseDialog({
    super.key,
    required this.horse,
  });

  final Horse horse;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xFFf5f6f7),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(children: [
        SizedBox(
          height: 16,
        ),
        LabelValueDetail(
          label: "馬名:",
          value: horse.name ?? "", // horse name
        ),
        Divider(),
        LabelValueDetail(
          label: "厩舎名:",
          value: horse.stable?.name ?? "", // stable name
        ),
        Divider(),
        LabelValueDetail(
          label: "担当者:",
          value: horse.user?.username ?? "", // person in charge
        ),
        Divider(),
        LabelValueDetail(
          label: "馬主名:",
          value: horse.ownerName ?? "", // owner name
        ),
        Divider(),
        LabelValueDetail(
          label: "生産牧場名:",
          value: horse.farmName ?? "", // farm name
        ),
        Divider(),
        LabelValueDetail(
          label: "育成場名:",
          value: horse.trainingFarmName ?? "", // training farm name
        ),
        Divider(),
        LabelValueDetail(
          label: "性齢:",
          value: horse.getGenderAndAge, // sexual age
        ),
        Divider(),
        LabelValueDetail(
          label: "毛色:",
          value: horse.color ?? "", // color
        ),
        Divider(),
        LabelValueDetail(
          label: "クラス:",
          value: horse.horseClass ?? "", // class
        ),
        Divider(),
        LabelValueDetail(
          label: "父:",
          value: horse.fatherName ?? "", // father
        ),
        Divider(),
        LabelValueDetail(
          label: "母:",
          value: horse.motherName ?? "", // mother
        ),
        Divider(),
        LabelValueDetail(
          label: "母父:",
          value: horse.motherFatherName ?? "", // mother / father
        ),
        Divider(),
        LabelValueDetail(
          label: "総賞金:",
          value: horse.totalStake?.toString() ?? "0.0", // total stake
        ),
        Divider(),
        LabelValueDetail(
          label: "メモ:",
          value: horse.memo ?? "", // memo
        ),
        SizedBox(
          height: 60,
        )
      ]),
    );
  }
}
