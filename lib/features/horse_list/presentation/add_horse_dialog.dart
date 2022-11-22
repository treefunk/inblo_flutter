import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_picker/flutter_picker.dart';

import 'package:inblo_app/common_widgets/inblo_text_button.dart';
import 'package:inblo_app/common_widgets/inblo_text_field.dart';
import 'package:inblo_app/constants/app_constants.dart';
import 'package:inblo_app/features/horse_list/providers/dropdown.dart';
import 'package:inblo_app/features/horse_list/providers/horses.dart';
import 'package:provider/provider.dart';

class AddHorseDialog extends StatefulWidget {
  const AddHorseDialog({super.key});

  @override
  State<AddHorseDialog> createState() => _AddHorseDialogState();
}

class _AddHorseDialogState extends State<AddHorseDialog> {
  final _nameController = TextEditingController();
  final _ownerNameController = TextEditingController();
  final _farmNameController = TextEditingController();
  final _trainingFarmNameController = TextEditingController();

  final _classController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _fatherController = TextEditingController();
  final _motherController = TextEditingController();
  final _motherFatherConroller = TextEditingController();
  final _totalStakeController = TextEditingController();
  final _notesController = TextEditingController();

  int? _personInCharge;
  String _sex = "";
  String _color = "";

  final List<String> _colorChoices = [
    "鹿毛",
    "黒鹿毛",
    "青鹿毛",
    "青毛",
    "芦毛",
    "栗毛",
    "栃栗毛",
    "白毛"
  ];

  final List<String> _sexChoices = ["牡", "牝", "騙"];

  final _form = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  bool validateForm() {
    return _form.currentState?.validate() ?? false;
  }

  void _addHorse() async {
    if (!validateForm()) {
      return;
    }

    var horses = Provider.of<Horses>(context, listen: false);
    var add = await horses.addHorse(
      name: _nameController.text,
      userId: _personInCharge ?? 0,
      sex: _sex,
      color: _color,
      ownerName: _ownerNameController.text,
      farmName: _farmNameController.text,
      trainingFarmName: _trainingFarmNameController.text,
      birthDate: _birthDateController.text,
      father: _fatherController.text,
      mother: _motherController.text,
      motherFatherName: _motherFatherConroller.text,
      horseClass: _classController.text,
      totalStake: double.parse(_totalStakeController.text),
      memo: _notesController.text,
      horseId: null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: Column(
        children: [
          SizedBox(
            height: 16,
          ),
          InbloTextField(
            textHint: "馬名", // horse name
            controller: _nameController,
            validator: ((value) {
              if (value != null && value.isEmpty) {
                return "馬名を入力してください。";
              }
              return null;
            }),
          ),
          SizedBox(height: 12),
          // "担当者"
          Consumer<Dropdown>(
              builder: ((ctx, dropdown, child) => InbloDropdownTextField(
                    onChanged: (value) {
                      if (value.toString().isNotEmpty) {
                        _personInCharge = value;
                      } else {
                        _personInCharge = null;
                      }
                    },
                    items: dropdown.personInChargeOptions
                        .map((p) => DropdownMenuItem(
                            value: p.id, child: Text(p.name ?? "")))
                        .toList(),
                    textHint: "担当者", // person in charge
                  ))),
          SizedBox(height: 12),
          InbloTextField(
            textHint: "馬主名", // owner name
            controller: _ownerNameController,
          ),
          SizedBox(height: 12),
          InbloTextField(
            textHint: "生産牧場名", // farm name
            controller: _farmNameController,
          ),
          SizedBox(height: 12),
          InbloTextField(
            textHint: "育成場名", // training farm name
            controller: _trainingFarmNameController,
          ),
          SizedBox(height: 12),
          InbloDatePickerField(
            onSelectDate: (selectedDate) {
              setState(() {
                _birthDateController.text = selectedDate;
              });
            },
            pickerAdapter: DateTimePickerAdapter(
              maxValue: DateTime.now(),
            ),
            controller: _birthDateController,
            textHint: "生年月日",
          ),
          SizedBox(height: 12),

          InbloDropdownTextField(
            onChanged: (value) {
              _sex = value;
            },
            items: ["", ..._sexChoices]
                .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                .toList(),
            textHint: "性", // sex
          ),
          SizedBox(height: 12),
          InbloDropdownTextField(
            onChanged: (value) {
              _color = value;
            },
            items: ["", ..._colorChoices]
                .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                .toList(),
            textHint: "毛色", // color
          ),

          SizedBox(height: 12),
          InbloTextField(
            textHint: "クラス", // class
            controller: _classController,
          ),
          SizedBox(height: 12),
          InbloTextField(
            textHint: "父", // father
            controller: _fatherController,
          ),
          SizedBox(height: 12),
          InbloTextField(
            textHint: "母", // mother
            controller: _motherController,
          ),
          SizedBox(height: 12),
          InbloTextField(
            textHint: "母父", // mother / father
            controller: _motherFatherConroller,
          ),
          SizedBox(height: 12),
          InbloTextField(
            textHint: "総賞金", // total stake
            inputType: TextInputType.number,
            controller: _totalStakeController,
            inputFormatters: [
              AppConstants.filterDecimal,
            ],
          ),
          SizedBox(height: 12),
          InbloTextField(
            textHint: "メモを書く...", // notes
            maxLines: 6,
            controller: _notesController,
          ),
          SizedBox(
            height: 16,
          ),
          InbloTextButton(
            onPressed: _addHorse,
            title: "＋ 追加",
            textStyle: TextStyleInbloButton.big,
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ownerNameController.dispose();
    _farmNameController.dispose();
    _trainingFarmNameController.dispose();
    _classController.dispose();
    _birthDateController.dispose();
    _fatherController.dispose();
    _motherController.dispose();
    _motherFatherConroller.dispose();
    _totalStakeController.dispose();
    _notesController.dispose();
    super.dispose();
  }
}
