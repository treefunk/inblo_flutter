import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:inblo_app/common_widgets/general_dialog.dart';
import 'package:inblo_app/common_widgets/inblo_text_button.dart';
import 'package:inblo_app/common_widgets/inblo_text_field.dart';
import 'package:inblo_app/constants/app_constants.dart';
import 'package:inblo_app/constants/app_theme.dart';
import 'package:inblo_app/features/horse_details/file_attachments/attachments_box.dart';
import 'package:inblo_app/features/tab_daily_reports/providers/daily_reports.dart';
import 'package:inblo_app/models/attached_file.dart';
import 'package:inblo_app/models/daily_report.dart';
import 'package:inblo_app/models/dropdown_data.dart';
import 'package:inblo_app/models/meta_response.dart';
import 'package:provider/provider.dart';
import 'package:inblo_app/constants/my_ext.dart';

class AddDailyReportDialog extends StatefulWidget {
  AddDailyReportDialog({super.key, this.dailyReport});

  DailyReport? dailyReport;

  @override
  State<AddDailyReportDialog> createState() => _AddDailyReportDialogState();
}

class _AddDailyReportDialogState extends State<AddDailyReportDialog> {
  // final _dateKey = GlobalKey();
  final _dateFocusNode = FocusNode();
  final _dateController = TextEditingController();

  final _bodyTempController = TextEditingController();
  final _horseWeightController = TextEditingController();

  bool _isLoading = false;

  int? _riderId;
  int? _trainingTypeId;

  List<AttachedFile> _attachedFiles = [];
  late List<AttachedFile> attachedFiles;
  final List<AttachedFile> _uploadedFiles = [];

  List<AttachedFile> get currentAndUploadedFiles {
    return attachedFiles + _uploadedFiles;
  }

  final _time5fController = TextEditingController();
  final _time4fController = TextEditingController();
  final _time3fController = TextEditingController();
  final _memoController = TextEditingController();

  final List<String> conditionGroupChoices = ["良", "稍重", "重", "不良"];
  String? _conditionGroup;

  final _trainingAmountController = TextEditingController();

  final _form = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    print("init add daily report");

    initFields();

    //clone to avoid side effects on original data
    attachedFiles = [..._attachedFiles];
    _dateFocusNode.requestFocus();
  }

  void initFields() {
    if (widget.dailyReport != null) {
      var dailyReport = widget.dailyReport!;
      _dateController.text = dailyReport.formattedDate ?? "";
      _bodyTempController.text = dailyReport.bodyTemperature.toString();
      _horseWeightController.text = dailyReport.horseWeight.toString();
      _riderId = dailyReport.rider?.id;
      _trainingTypeId = dailyReport.trainingType?.id;
      _conditionGroup = dailyReport.conditionGroup;
      _time5fController.text = dailyReport.time5f?.toString() ?? "";
      _time4fController.text = dailyReport.time4f?.toString() ?? "";
      _time3fController.text = dailyReport.time3f?.toString() ?? "";
      _memoController.text = dailyReport.memo ?? "";
      _trainingAmountController.text = dailyReport.trainingAmount ?? "";

      if (dailyReport.attachedFiles != null &&
          dailyReport.attachedFiles!.isNotEmpty) {
        _attachedFiles = dailyReport.attachedFiles!;
      }
    }
  }

  bool _validateForm() {
    return _form.currentState?.validate() ?? false;
  }

  void _addDailyReport(BuildContext context) async {
    if (!_validateForm()) {
      await showOkDialog(context, "Error", "Please enter required fields.");
      return;
    }

    var dailyReportsProvider =
        Provider.of<DailyReports>(context, listen: false);
    var selectedHorse = context.read<DailyReports>().selectedHorse;

    if (selectedHorse == null) {
      return;
    }

    _setLoading(true);
    var getDailyReportResponse = await dailyReportsProvider.addDailyReport(
      horseId: selectedHorse.id!,
      date: _dateController.text,
      bodyTemperature: _bodyTempController.text.parseDoubleOrZero(),
      horseWeight: _horseWeightController.text.parseIntOrZero(),
      conditionGroup: _conditionGroup ?? "",
      riderId: _riderId,
      trainingTypeId: _trainingTypeId,
      trainingAmount: _trainingAmountController.text,
      time5f: _time5fController.text.parseDoubleOrZero(),
      time4f: _time4fController.text.parseDoubleOrZero(),
      time3f: _time3fController.text.parseDoubleOrZero(),
      memo: _memoController.text,
      dailyAttachedIds:
          attachedFiles.map((attached) => attached.id.toString()).toList(),
      uploadedFiles: _uploadedFiles,
      id: widget.dailyReport?.id,
    );
    _setLoading(false);

    MetaResponse metaResponse = getDailyReportResponse.metaResponse;

    var message = widget.dailyReport == null
        ? "Daily report Successfully created!"
        : "Daily report Successfully updated!";
    if (metaResponse.code == 201) {
      if (!mounted) return;
      await showOkDialog(context, "Success", message);
      if (!mounted) return;
      Navigator.of(context).pop();
    }
    print(metaResponse.message);
  }

  @override
  Widget build(BuildContext context) {
    // var riders = Provider.of<DailyReports>(context, listen: false).riderOptions;

    // print("rod")
    return Form(
      key: _form,
      child: Column(
        children: [
          SizedBox(
            height: 16,
          ),
          InbloDatePickerField(
            focusNode: _dateFocusNode,
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

            // focusNode: _dateFocusNode,
            textHint: "日付*", // date
            isRequired: true,
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
            controller: _horseWeightController,
            inputType: TextInputType.numberWithOptions(decimal: false),
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(r'\.\d*'))
            ],
            validator: ((value) {
              if (value != null && value.isNotEmpty) {
                if (!AppConstants.wholeNumberRegX.hasMatch(value)) {
                  return "Invalid Weight Format.";
                }
              }
            }),
          ),
          SizedBox(
            height: 12,
          ),
          InbloDropdownTextField(
            onChanged: (value) {
              _conditionGroup = value;
            },
            items: ["", ...conditionGroupChoices]
                .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                .toList(),
            textHint: "馬場状態", // condition group
            value: _conditionGroup,
          ),
          SizedBox(
            height: 12,
          ),
          Consumer<DailyReports>(builder: (context, dailyReports, child) {
            return InbloDropdownTextField(
              onChanged: (value) {
                if (value.toString().isNotEmpty) {
                  _riderId = value;
                } else {
                  _riderId = null;
                }
              },
              items: [DropdownData(), ...dailyReports.riderOptions]
                  .map((r) => DropdownMenuItem(
                        value: r.id,
                        child: Text(r.name ?? ""),
                      ))
                  .toList(),
              value: _riderId,
              textHint: "乗り手", // rider name
            );
          }),
          SizedBox(
            height: 12,
          ),
          Consumer<DailyReports>(builder: (context, dailyReports, child) {
            return InbloDropdownTextField(
              onChanged: (value) {
                if (value.toString().isNotEmpty) {
                  _trainingTypeId = value;
                } else {
                  _trainingTypeId = null;
                }
              },
              items: [DropdownData(), ...dailyReports.trainingTypeOptions]
                  .map((t) => DropdownMenuItem(
                        value: t.id,
                        child: Text(t.name ?? ""),
                      ))
                  .toList(),
              value: _trainingTypeId,
              textHint: "調教内容", // training type
            );
          }),
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
                  controller: _time5fController,
                  validator: ((value) {
                    if (value != null && value.isNotEmpty) {
                      if (!AppConstants.wholeAndDecimalRegX.hasMatch(value)) {
                        return "Invalid value.";
                      }
                    }
                  }),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: InbloTextField(
                  textHint: "4F",
                  inputType: TextInputType.number,
                  controller: _time4fController,
                  validator: ((value) {
                    if (value != null && value.isNotEmpty) {
                      if (!AppConstants.wholeAndDecimalRegX.hasMatch(value)) {
                        return "Invalid value.";
                      }
                    }
                  }),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: InbloTextField(
                  textHint: "3F",
                  inputType: TextInputType.number,
                  controller: _time3fController,
                  validator: ((value) {
                    if (value != null && value.isNotEmpty) {
                      if (!AppConstants.wholeAndDecimalRegX.hasMatch(value)) {
                        return "Invalid value.";
                      }
                    }
                  }),
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
            controller: _memoController,
          ),
          SizedBox(
            height: 16,
          ),
          AttachmentsBox(
            viewDir: AttachmentDir.dailyReports,
            attachedFiles: currentAndUploadedFiles,
            onCaptureImage: (attachedFile) {
              setState(() {
                _uploadedFiles.add(attachedFile);
              });
            },
            onPickFile: (attachedFile) {
              setState(() {
                _uploadedFiles.add(attachedFile);
              });
            },
            onDeleteExisting: (index) {
              setState(() {
                attachedFiles.removeAt(index);
              });
            },
            onDeleteUploaded: (index) {
              setState(() {
                _uploadedFiles.removeAt(index);
              });
            },
          ),
          SizedBox(
            height: 10,
          ),
          _isLoading
              ? CircularProgressIndicator()
              : InbloTextButton(
                  onPressed: () => _addDailyReport(context),
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

  @override
  void dispose() {
    _dateController.dispose();
    _bodyTempController.dispose();
    _horseWeightController.dispose();
    _time5fController.dispose();
    _time4fController.dispose();
    _time3fController.dispose();
    _memoController.dispose();
    _trainingAmountController.dispose();
    _dateFocusNode.dispose();
    super.dispose();
  }
}
