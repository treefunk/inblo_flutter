import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

import '../constants/app_theme.dart';

const inbloTextFieldStyle = TextStyle(
  color: Colors.black,
  fontSize: 16,
  fontFamily: "Hiragino",
);

InputDecoration getInputDecoration({
  required BuildContext context,
  required String textHint,
  bool isDense = false,
}) =>
    InputDecoration(
      labelText: textHint,
      isDense: isDense,
      alignLabelWithHint: true,
      labelStyle: TextStyle(
        color: Color(0xFFA8A8A8),
        fontFamily: "Hiragino",
        letterSpacing: 3,
      ),
      floatingLabelStyle: TextStyle(
        // color: Color(0xFF2F2525),
        color: themeData.primaryColor,
        fontFamily: "Hiragino",
        letterSpacing: 3,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1.5,
          color: Theme.of(context).primaryColor,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 2, color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(4),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 2, color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(4),
      ),
    );

class InbloTextField extends StatelessWidget {
  final String textHint;
  final int maxLines;
  final TextEditingController? controller;
  final TextInputType? inputType;

  const InbloTextField({
    this.textHint = "- - - - -",
    this.maxLines = 1,
    this.controller,
    this.inputType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: inbloTextFieldStyle,
      keyboardType: inputType,
      decoration: getInputDecoration(context: context, textHint: textHint),
      maxLines: maxLines,
      controller: controller,
      // textAlign: TextAlign.left,
      // textAlignVertical: TextAlignVertical.top,
    );
  }
}

class InbloDropdownTextField extends StatelessWidget {
  final Function(dynamic) onChanged;
  final String textHint;
  final List<DropdownMenuItem> items;
  final TextEditingController? controller;

  const InbloDropdownTextField({
    required this.onChanged,
    this.textHint = "- - - - -",
    required this.items,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      onChanged: onChanged,
      items: items,
      style: inbloTextFieldStyle,
      decoration: getInputDecoration(
          context: context, textHint: textHint, isDense: true),
    );
  }
}

class InbloDatePickerField extends StatelessWidget {
  final Function(String selectedDate) onSelectDate;
  final PickerAdapter pickerAdapter;
  final String textHint;
  final TextEditingController? controller;

  const InbloDatePickerField({
    required this.onSelectDate,
    required this.pickerAdapter,
    this.textHint = "- - - - -",
    this.controller,
  });

  showPickerDate(
      BuildContext context,
      Function(Picker picker, List value) onConfirm,
      PickerAdapter pickerAdapter) {
    Picker(
            hideHeader: true,
            adapter: pickerAdapter,
            title: Text("Select Date"),
            selectedTextStyle: TextStyle(color: colorPrimary),
            onConfirm: onConfirm)
        .showDialog(context);

    // print(dateSelected as DateTimePickerAdapter));
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () {
        // DateTime? dt = await _selectDate(context);
        // if (dt != null) onSelectDate(dt.toString());
        showPickerDate(context, (picker, value) {
          var selected = (picker.adapter as DateTimePickerAdapter).value;
          onSelectDate(selected.toString());
        }, pickerAdapter);
      },
      style: inbloTextFieldStyle,
      readOnly: true,

      decoration: getInputDecoration(context: context, textHint: textHint),
      // textAlign: TextAlign.left,
      controller: controller,
      // textAlignVertical: TextAlignVertical.top,
    );
  }
}

class InbloNumberPicker extends StatelessWidget {
  final Function(List<dynamic> selectedData) onSelectData;
  final PickerAdapter pickerAdapter;
  final String dialogTitle;
  final String textHint;
  final Widget? delimiter;
  final TextEditingController? controller;

  const InbloNumberPicker({
    required this.onSelectData,
    required this.pickerAdapter,
    required this.dialogTitle,
    this.delimiter,
    this.textHint = "- - - - -",
    this.controller,
  });

  showPickerNumber(BuildContext context, PickerAdapter pickerAdapter,
      Function(Picker picker, List value) onConfirm) {
    var selected = Picker(
      adapter: pickerAdapter,
      delimiter: [
        if (delimiter != null)
          PickerDelimiter(
              child: Container(
            width: 25.0,
            alignment: Alignment.center,
            child: delimiter,
          ))
      ],
      hideHeader: true,
      title: new Text(dialogTitle),
      onConfirm: onConfirm,
      // (Picker picker, List value) {
      //   print(value.toString());
      //   print(picker.getSelectedValues());
      // }
    ).showDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () async {
        // DateTime? dt = await _selectDate(context);
        // if (dt != null) onSelectDate(dt.toString());
        showPickerNumber(context, pickerAdapter, (picker, value) {
          // print(picker.getSelectedValues());
          onSelectData(picker.getSelectedValues());
        });
      },
      style: inbloTextFieldStyle,
      readOnly: true,

      decoration: getInputDecoration(context: context, textHint: textHint),
      // textAlign: TextAlign.left,
      controller: controller,
      // textAlignVertical: TextAlignVertical.top,
    );
  }
}
