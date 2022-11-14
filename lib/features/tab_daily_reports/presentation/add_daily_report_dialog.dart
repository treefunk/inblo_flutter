import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:inblo_app/common_widgets/inblo_text_button.dart';
import 'package:inblo_app/common_widgets/inblo_text_field.dart';

class AddDailyReportDialog extends StatefulWidget {
  const AddDailyReportDialog({super.key});

  @override
  State<AddDailyReportDialog> createState() => _AddDailyReportDialogState();
}

class _AddDailyReportDialogState extends State<AddDailyReportDialog> {
  final _dateController = TextEditingController();
  final _bodyTempController = TextEditingController();
  final _trainingAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 16,
        ),
        InbloDatePickerField(
          pickerAdapter: DateTimePickerAdapter(
            maxValue: DateTime.now(),
          ),
          onSelectDate: (selectedDate) async {
            setState(() {
              _dateController.text = selectedDate;
            });
            print(selectedDate);
          },
          controller: _dateController,
          textHint: "日付*", // date
        ),
        SizedBox(height: 12),
        InbloNumberPicker(
          onSelectData: ((selectedData) {
            print(selectedData);
            setState(() {
              _bodyTempController.text = selectedData.join(".");
            });
          }),
          pickerAdapter: NumberPickerAdapter(data: [
            NumberPickerColumn(begin: 35, end: 42),
            NumberPickerColumn(begin: 0, end: 9),
          ]),
          delimiter: Text("."),
          dialogTitle: "Please Select body temperature",
          textHint: "体温", // body temp
          controller: _bodyTempController,
        ),
        SizedBox(
          height: 12,
        ),
        InbloTextField(
          textHint: "馬体重", //weight
          inputType: TextInputType.number,
        ),
        SizedBox(
          height: 12,
        ),
        InbloDropdownTextField(
          onChanged: (value) {},
          items: [
            DropdownMenuItem(value: "1", child: Text("Condition group")),
            DropdownMenuItem(value: "2", child: Text("Condition group 2")),
            DropdownMenuItem(value: "3", child: Text("Condition group 3")),
            DropdownMenuItem(value: "4", child: Text("Condition group 4")),
          ],
          textHint: "馬場状態", // condition group
        ),
        SizedBox(
          height: 12,
        ),
        InbloDropdownTextField(
          onChanged: (value) {},
          items: [
            DropdownMenuItem(value: "1", child: Text("Rider")),
            DropdownMenuItem(value: "2", child: Text("Rider 2")),
            DropdownMenuItem(value: "3", child: Text("Rider 3")),
            DropdownMenuItem(value: "4", child: Text("Rider 4")),
          ],
          textHint: "乗り手", // rider name
        ),
        SizedBox(
          height: 12,
        ),
        InbloDropdownTextField(
          onChanged: (value) {},
          items: [
            DropdownMenuItem(value: "1", child: Text("Training type")),
            DropdownMenuItem(value: "2", child: Text("Training type 2")),
            DropdownMenuItem(value: "3", child: Text("Training type 3")),
            DropdownMenuItem(value: "4", child: Text("Training type 4")),
          ],
          textHint: "調教内容", // training type
        ),
        SizedBox(
          height: 12,
        ),
        InbloNumberPicker(
          onSelectData: ((selectedData) {
            print(selectedData);
            setState(() {
              _trainingAmountController.text = selectedData.join(".");
            });
          }),
          pickerAdapter: NumberPickerAdapter(data: [
            NumberPickerColumn(begin: 0, end: 8000, jump: 200),
          ]),
          dialogTitle: "Please Select Training Amount",
          textHint: "調教量", // training amount
          controller: _trainingAmountController,
        ),
        SizedBox(
          height: 12,
        ),
        Row(
          children: [
            Expanded(
              child: InbloTextField(
                textHint: "5F",
                inputType: TextInputType.number,
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: InbloTextField(
                textHint: "4F",
                inputType: TextInputType.number,
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: InbloTextField(
                textHint: "3F",
                inputType: TextInputType.number,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 12,
        ),
        InbloTextField(
          textHint: "メモを書く...", // notes
          maxLines: 6,
        ),
        SizedBox(
          height: 16,
        ),
        //todo add upload btn here ( ファイルを追加 )
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
