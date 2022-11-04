import 'package:flutter/material.dart';

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

  const InbloTextField({
    this.textHint = "- - - - -",
    this.maxLines = 1,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: inbloTextFieldStyle,
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
  final String textHint;
  final TextEditingController? controller;

  const InbloDatePickerField({
    required this.onSelectDate,
    this.textHint = "- - - - -",
    this.controller,
  });

  Future<DateTime?> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.fromMicrosecondsSinceEpoch(0),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );

    return picked;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () async {
        DateTime? dt = await _selectDate(context);
        if (dt != null) onSelectDate(dt.toString());
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
