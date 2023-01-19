import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inblo_app/constants/app_constants.dart';
import 'package:intl/intl.dart';

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
  Widget? suffixIcon,
}) =>
    InputDecoration(
      suffixIcon: suffixIcon,
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
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1.5, color: Theme.of(context).errorColor),
        borderRadius: BorderRadius.circular(4),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 2, color: Theme.of(context).errorColor),
        borderRadius: BorderRadius.circular(4),
      ),
    );

class InbloTextField extends StatelessWidget {
  const InbloTextField({
    this.textHint = "- - - - -",
    this.maxLines = 1,
    this.controller,
    this.inputType,
    this.obscureText = false,
    this.enableSuggestion = true,
    this.autocorrect = true,
    this.isRequired,
    this.validator,
    this.focusNode,
    this.autofocus = true,
    this.inputFormatters,
    this.initialValue,
  });

  final String textHint;
  final int maxLines;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final bool obscureText;
  final bool enableSuggestion;
  final bool autocorrect;
  final bool? isRequired;
  final String? Function(String? value)? validator;
  final FocusNode? focusNode;
  final bool autofocus;
  final List<TextInputFormatter>? inputFormatters;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: inbloTextFieldStyle,
      keyboardType: inputType,
      decoration: getInputDecoration(context: context, textHint: textHint),
      maxLines: maxLines,
      controller: controller,
      obscureText: obscureText,
      enableSuggestions: enableSuggestion,
      autocorrect: autocorrect,
      validator: (value) {
        if (isRequired != null &&
            isRequired! &&
            value != null &&
            value.isEmpty) {
          return "This field is required.";
        }
        if (validator != null) {
          return validator!(value);
        }
        return null;
      },
      focusNode: focusNode,
      autofocus: autofocus,
      inputFormatters: inputFormatters,
      initialValue: initialValue,
      onSaved: (newValue) {
        print("on saved fired");
      },
      onFieldSubmitted: (value) {
        print("on field submitted");
      },
    );
  }
}

class InbloDropdownTextField extends StatefulWidget {
  final Function(dynamic) onChanged;
  final String textHint;
  final List<DropdownMenuItem> items;
  final String? Function(dynamic value)? validator;
  dynamic value;
  final bool? isRequired;
  final void Function()? onClearValue;
  final GlobalKey<FormFieldState> _key = GlobalKey<FormFieldState>();

  InbloDropdownTextField({
    required this.onChanged,
    this.textHint = "- - - - -",
    required this.items,
    this.validator,
    this.value,
    this.isRequired = false,
    this.onClearValue,
  });

  @override
  State<InbloDropdownTextField> createState() => _InbloDropdownTextFieldState();
}

class _InbloDropdownTextFieldState extends State<InbloDropdownTextField> {
  bool _isNull = true;

  @override
  void initState() {
    _isNull = widget.value == null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      onChanged: (value) {
        // if (value == null) {
        //   setState(() {
        //     _isNull = true;
        //   });
        // } else {
        //   setState(() {
        //     _isNull = false;
        //   });
        // }
        widget.onChanged(value);
      },
      items: widget.items,
      style: inbloTextFieldStyle,
      decoration: getInputDecoration(
        context: context,
        textHint: widget.textHint,
        isDense: true,
        suffixIcon:
            // !_isNull
            false
                ? Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Stack(
                      children: [
                        SvgPicture.asset(
                          "assets/svg/ic-close.svg",
                          height: 20,
                          width: 20,
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              // print("clear value");
                              // widget.onClearValue?.call();
                              // widget._key.currentState?.reset();
                            },
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : null,
      ),
      validator: (value) {
        if (widget.isRequired != null &&
            widget.isRequired! &&
            (value != null && value.isEmpty)) {
          return "This field is required.";
        }
        if (widget.validator != null) {
          return widget.validator!(value);
        }
        return null;
      },
      value: widget.value,
    );
  }
}

class InbloDatePickerField extends StatelessWidget {
  final Function(String selectedDate) onSelectDate;
  final PickerAdapter pickerAdapter;
  final Key? datepickerKey;
  final String textHint;
  final TextEditingController? controller;
  final String? Function(String? value)? validator;
  final bool? isRequired;
  final Widget? suffixIcon;
  final FocusNode? focusNode;

  const InbloDatePickerField({
    required this.onSelectDate,
    required this.pickerAdapter,
    this.datepickerKey,
    this.textHint = "- - - - -",
    this.controller,
    this.validator,
    this.isRequired,
    this.suffixIcon,
    this.focusNode,
  });

  void showPickerDate(
      BuildContext context,
      Function(Picker picker, List value) onConfirm,
      PickerAdapter pickerAdapter) {
    Picker(
      hideHeader: true,
      adapter: pickerAdapter,
      title: Text("Select Date"),
      selectedTextStyle: TextStyle(color: colorPrimary),
      onConfirm: onConfirm,
    ).showDialog(context);

    // print(dateSelected as DateTimePickerAdapter));
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: (newValue) {
        print("on saved fired");
      },
      onFieldSubmitted: (value) {
        print("on field submitted");
      },
      onTap: () {
        showPickerDate(context, (picker, value) {
          var selected = (picker.adapter as DateTimePickerAdapter).value;
          var dateFormat = AppConstants.dateOnlyFormatYmd;
          if (selected != null) {
            var formattedDateString = DateFormat(dateFormat).format(selected);
            onSelectDate(formattedDateString);
          }
        }, pickerAdapter);
      },
      key: datepickerKey,
      style: inbloTextFieldStyle,
      readOnly: true,
      decoration: getInputDecoration(
        context: context,
        textHint: textHint,
        suffixIcon: suffixIcon,
      ),
      // textAlign: TextAlign.left,
      controller: controller,
      // textAlignVertical: TextAlignVertical.top,
      validator: (value) {
        if (isRequired != null &&
            isRequired! &&
            value != null &&
            value.isEmpty) {
          return "This field is required.";
        }
        if (validator != null) {
          return validator!(value);
        }
        return null;
      },
      focusNode: focusNode,
    );
  }
}

class InbloNumberPicker extends StatelessWidget {
  final Function(List<dynamic> selectedData) onSelectData;
  final PickerAdapter pickerAdapter;
  final String dialogTitle;
  final String textHint;
  final Widget? delimiter;
  final String? Function(String? value)? validator;

  final TextEditingController? controller;

  const InbloNumberPicker({
    required this.onSelectData,
    required this.pickerAdapter,
    required this.dialogTitle,
    this.delimiter,
    this.textHint = "- - - - -",
    this.controller,
    this.validator,
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
      validator: validator,
    );
  }
}
