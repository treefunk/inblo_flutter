import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:inblo_app/common_widgets/general_dialog.dart';

import 'package:inblo_app/common_widgets/inblo_text_button.dart';
import 'package:inblo_app/common_widgets/inblo_text_field.dart';
import 'package:inblo_app/constants/app_constants.dart';
import 'package:inblo_app/features/horse_list/providers/persons_in_charge.dart';
import 'package:inblo_app/features/horse_list/providers/horses.dart';
import 'package:inblo_app/models/horse.dart';
import 'package:inblo_app/models/meta_response.dart';
import 'package:provider/provider.dart';

class AddHorseDialog extends StatefulWidget {
  AddHorseDialog(
    this.dialogContext, {
    super.key,
    this.horse,
  });
  final BuildContext dialogContext;
  Horse? horse;

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

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

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

    if (widget.horse != null) {
      initFields();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  bool validateForm() {
    return _form.currentState?.validate() ?? false;
  }

  void _addHorse(
    ScaffoldMessengerState scaffoldMessengerState,
    NavigatorState contextNavigator,
  ) async {
    if (!validateForm()) {
      await showOkDialog(context, "Error", "Please enter required fields.");
      return;
    }

    var horses = Provider.of<Horses>(context, listen: false);
    var getHorseResponse = await horses.addHorse(
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
      totalStake: _totalStakeController.text.isEmpty
          ? 0.0
          : double.parse(_totalStakeController.text),
      memo: _notesController.text,
      horseId: widget.horse?.id,
    );

    MetaResponse metaResponse = getHorseResponse.metaResponse;

    if (metaResponse.code == 201) {
      if (widget.horse != null) {
        setState(() {
          widget.horse = getHorseResponse.data;
        });
      }
      scaffoldMessengerState.showSnackBar(
        SnackBar(
          content: Text(
            metaResponse.message,
          ),
        ),
      );
      contextNavigator.pop();
    } else {
      await showOkDialog(context, "Error", metaResponse.message);
    }
  }

  void initFields() {
    // print(json.encode(widget.horse!));
    _nameController.text = widget.horse?.name ?? "";
    _ownerNameController.text = widget.horse?.ownerName ?? "";
    _farmNameController.text = widget.horse?.farmName ?? "";
    _trainingFarmNameController.text = widget.horse?.trainingFarmName ?? "";

    _classController.text = widget.horse?.horseClass ?? "";
    _birthDateController.text = widget.horse?.getBirthDateOnly ?? "";
    _fatherController.text = widget.horse?.fatherName ?? "";
    _motherController.text = widget.horse?.motherName ?? "";
    _motherFatherConroller.text = widget.horse?.motherFatherName ?? "";
    _totalStakeController.text = (widget.horse?.totalStake ?? 0.0).toString();
    _notesController.text = widget.horse?.memo ?? "";

    // special fields
    if (widget.horse?.user != null) {
      _personInCharge = widget.horse?.user!.id;
    }

    _sex = widget.horse?.sex ?? "";
    _color = widget.horse?.color ?? "";
  }

  @override
  Widget build(BuildContext context) {
    var scaffoldMessenger = ScaffoldMessenger.of(widget.dialogContext);
    var contextNavigator = Navigator.of(context, rootNavigator: true);

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
          Consumer<PersonsInCharge>(
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
                    value: _personInCharge,
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
            value: _sex,
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
            value: _color,
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
              FilteringTextInputFormatter.allow(RegExp("[0-9.]"))
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
            onPressed: () => _addHorse(scaffoldMessenger, contextNavigator),
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
