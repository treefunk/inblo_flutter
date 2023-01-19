import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inblo_app/common_widgets/general_dialog.dart';
import 'package:inblo_app/common_widgets/inblo_text_button.dart';
import 'package:inblo_app/common_widgets/inblo_text_field.dart';
import 'package:inblo_app/constants/app_constants.dart';
import 'package:inblo_app/features/calendar/provider/calendar_events.dart';
import 'package:inblo_app/features/calendar/provider/event_types.dart';
import 'package:inblo_app/features/horse_list/providers/horses.dart';
import 'package:inblo_app/models/calendar_event.dart';
import 'package:inblo_app/models/horse.dart';
import 'package:inblo_app/models/meta_response.dart';
import 'package:provider/provider.dart';
import 'package:inblo_app/constants/my_ext.dart';

class AddEventDialog extends StatefulWidget {
  AddEventDialog({
    super.key,
    // required this.activeDateTime,
    this.horse,
    this.calendarEvent,
    this.onUpdate,
  });

  // DateTime activeDateTime;
  Horse? horse;
  CalendarEvent? calendarEvent;
  void Function()? onUpdate;

  @override
  State<AddEventDialog> createState() => _AddEventDialogState();
}

class _AddEventDialogState extends State<AddEventDialog> {
  final _form = GlobalKey<FormState>();

  final _titleFocusNode = FocusNode();

  final _titleController = TextEditingController();
  final _dateController = TextEditingController();
  final _dateEndController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();

  bool _isLoading = false;

  int? _horseId;
  String? _eventType;
  final _memoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    var horseProvider = Provider.of<Horses>(context, listen: false);

    _titleFocusNode.requestFocus();

    initFields();
  }

  void initFields() {
    if (widget.calendarEvent != null) {
      var existingEvent = widget.calendarEvent!;
      _dateController.text =
          existingEvent.date.format(AppConstants.dateOnlyFormatYmd);
      _dateEndController.text =
          existingEvent.dateEnd.format(AppConstants.dateOnlyFormatYmd);
      _titleController.text = existingEvent.title;
      _eventType = existingEvent.eventType;
      _startTimeController.text = existingEvent.start;
      _endTimeController.text = existingEvent.end;

      if (existingEvent.horse != null) {
        _horseId = existingEvent.horseId;
      }

      _memoController.text = existingEvent.memo;
    }

    if (widget.horse != null) {
      _horseId = widget.horse!.id;
    }
  }

  bool _validateForm() {
    return _form.currentState?.validate() ?? false;
  }

  void _addEvent(BuildContext context) async {
    if (!_validateForm()) {
      await showOkDialog(context, "Error", "Please enter required fields.");
      return;
    }

    var calendarEventsProvider =
        Provider.of<CalendarEvents>(context, listen: false);

    _setLoading(true);
    var addEventResponse = await calendarEventsProvider.addCalendarEvent(
      _horseId,
      _dateController.text,
      _dateEndController.text,
      _titleController.text,
      _eventType ?? "",
      _startTimeController.text,
      _endTimeController.text,
      _memoController.text,
      widget.calendarEvent?.id,
      // widget.activeDateTime
    );
    _setLoading(false);

    MetaResponse metaResponse = addEventResponse.metaResponse;
    if (metaResponse.code == 201 || metaResponse.code == 200) {
      if (!mounted) return;
      await showOkDialog(context, "Success", metaResponse.message);
      widget.onUpdate?.call();

      // calendarEventsProvider.fetchEventsByMonthYear(
      //   widget.activeDateTime.year,
      //   widget.activeDateTime.month,
      //   widget.calendarEvent?.horseId,
      // );
      if (mounted && metaResponse.code == 201) {
        Navigator.of(context, rootNavigator: true).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final hourList = List<String>.generate(24, (hour) => hour.withZeroPrefix());
    final minuteList =
        List<String>.generate(60, (minute) => minute.withZeroPrefix());

    return Form(
      key: _form,
      child: Column(
        children: [
          SizedBox(
            height: 16,
          ),
          InbloTextField(
            focusNode: _titleFocusNode,
            textHint: "タイトル*", //title
            controller: _titleController,
            isRequired: true,
          ),
          SizedBox(
            height: 12,
          ),
          InbloDropdownTextField(
            onChanged: (value) {
              _eventType = value;
            },
            items: ["", ...CalendarEventType.values.map((type) => type.name)]
                .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                .toList(),
            textHint: "イベントType *", // notification type
            value: _eventType,
            isRequired: true,
            validator: AppConstants.requireCallback,
          ),
          SizedBox(
            height: 12,
          ),
          // 開始日* label date start
          // 終了日 label date end
          // 開始時間 label start
          // 終了時間 label end
          // 管理馬名 label horse
          // メモを書く... label note
          InbloDatePickerField(
            pickerAdapter: DateTimePickerAdapter(
                // maxValue: DateTime.now(),
                ),
            onSelectDate: (selectedDate) async {
              setState(() {
                _dateController.text = selectedDate;
                if (_dateEndController.text.isNotEmpty) {
                  if (DateTime.parse(_dateEndController.text)
                      .isBefore(DateTime.parse(selectedDate))) {
                    _dateEndController.text = selectedDate;
                  }
                }
                if (_dateEndController.text.isEmpty) {
                  _dateEndController.text = selectedDate;
                }
              });
              print(selectedDate);
            },
            controller: _dateController,

            // focusNode: _dateFocusNode,
            textHint: "開始日*", // date start
            isRequired: true,
          ),

          SizedBox(
            height: 12,
          ),
          InbloDatePickerField(
            pickerAdapter: DateTimePickerAdapter(
              minValue: DateTime.now(),
            ),
            onSelectDate: (selectedDate) async {
              setState(() {
                _dateEndController.text = selectedDate;
                if (_dateController.text.isNotEmpty) {
                  if (DateTime.parse(_dateEndController.text)
                      .isBefore(DateTime.parse(_dateController.text))) {
                    _dateController.text = selectedDate;
                  }
                }
              });
              print(selectedDate);
            },
            suffixIcon: _dateEndController.text.isNotEmpty
                ? Container(
                    // padding: EdgeInsets.only(top: 10),
                    // color: Colors.green,
                    width: 20,
                    alignment: Alignment.center,
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
                              setState(() {
                                _dateEndController.clear();
                              });
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

            controller: _dateEndController,

            // focusNode: _dateFocusNode,
            textHint: "終了日", // date end
            isRequired: false,
          ),
          SizedBox(
            height: 12,
          ),
          InbloNumberPicker(
            onSelectData: ((selectedData) {
              print(selectedData);
              setState(() {
                _startTimeController.text = selectedData.join(":");
              });
            }),
            pickerAdapter: PickerDataAdapter<String>(
              pickerdata: [
                [...hourList.map((e) => e)],
                [...minuteList.map((e) => e)]
              ],
              isArray: true,
            ),
            delimiter: Text(":"),
            dialogTitle: "Please Select Start time:",
            textHint: "開始時間", // start time
            controller: _startTimeController,
          ),
          SizedBox(
            height: 12,
          ),
          Stack(
            children: [
              InbloNumberPicker(
                onSelectData: ((selectedData) {
                  print(selectedData);
                  setState(() {
                    _endTimeController.text = selectedData.join(":");
                  });
                }),
                pickerAdapter: PickerDataAdapter<String>(
                  pickerdata: [
                    [...hourList.map((e) => e)],
                    [...minuteList.map((e) => e)]
                  ],
                  isArray: true,
                ),
                delimiter: Text(":"),
                dialogTitle: "Please Select End time:",
                textHint: "終了時間", // end time
                controller: _endTimeController,
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Consumer<Horses>(
            builder: ((ctx, dropdown, child) => InbloDropdownTextField(
                  onChanged: (value) {
                    if (value.toString().isNotEmpty) {
                      _horseId = value;
                    } else {
                      _horseId = null;
                    }
                  },
                  items: widget.horse == null
                      ? [Horse(id: null, name: ""), ...dropdown.horses]
                          .map((p) {
                          return DropdownMenuItem(
                              value: p.id, child: Text(p.name ?? ""));
                        }).toList()
                      : [
                          DropdownMenuItem(
                              value: widget.horse!.id,
                              child: Text(widget.horse!.name ?? ""))
                        ].toList(),
                  textHint: "管理馬名", // horse
                  value: _horseId,
                )),
          ),
          SizedBox(
            height: 12,
          ),
          InbloTextField(
            textHint: "メモ......", // notes
            maxLines: 6,
            controller: _memoController,
          ),
          SizedBox(
            height: 16,
          ),
          _isLoading
              ? CircularProgressIndicator()
              : InbloTextButton(
                  onPressed: () => _addEvent(context),
                  title: "＋ 追加",
                  textStyle: TextStyleInbloButton.big)
        ],
      ),
    );
  }

  void _setLoading(bool state) {
    setState(() {
      _isLoading = state;
    });
  }
}
