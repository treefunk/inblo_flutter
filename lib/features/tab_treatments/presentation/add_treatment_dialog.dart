import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:inblo_app/common_widgets/general_dialog.dart';
import 'package:inblo_app/common_widgets/inblo_text_button.dart';
import 'package:inblo_app/common_widgets/inblo_text_field.dart';
import 'package:inblo_app/constants/app_constants.dart';
import 'package:inblo_app/features/horse_details/file_attachments/attachments_box.dart';
import 'package:inblo_app/models/attached_file.dart';
import 'package:inblo_app/models/meta_response.dart';
import 'package:inblo_app/models/treatment.dart';
import 'package:provider/provider.dart';

import '../providers/treatments.dart';

class AddTreatmentDialog extends StatefulWidget {
  AddTreatmentDialog({super.key, this.treatment});

  Treatment? treatment;

  @override
  State<AddTreatmentDialog> createState() => _AddTreatmentDialogState();
}

class _AddTreatmentDialogState extends State<AddTreatmentDialog> {
  final _dateFocusNode = FocusNode();
  final _dateController = TextEditingController();

  final List<String> occasionTypeChoice = [
    "故障・状態異常",
    "獣医診察",
    "治療",
    "装蹄",
    "飼い葉",
    "その他"
  ];
  String? _occasionType;

  final _injuredPartcontroller = TextEditingController();
  final _treatmentDetailController = TextEditingController();
  final _vetNameController = TextEditingController();
  final _drugNameController = TextEditingController();
  final _notesController = TextEditingController();

  final _form = GlobalKey<FormState>();

  bool _isLoading = false;

  List<AttachedFile> _attachedFiles = [];
  late List<AttachedFile> attachedFiles;
  final List<AttachedFile> _uploadedFiles = [];

  List<AttachedFile> get currentAndUploadedFiles {
    return attachedFiles + _uploadedFiles;
  }

  @override
  void initState() {
    super.initState();

    initFields();

    //clone to avoid side effects on original data
    attachedFiles = [..._attachedFiles];

    _dateFocusNode.requestFocus();
  }

  void initFields() {
    if (widget.treatment != null) {
      var treatment = widget.treatment!;
      _dateController.text = treatment.formattedDate ?? "";
      _occasionType = treatment.occasionType ?? "";

      _injuredPartcontroller.text = treatment.injuredPart?.toString() ?? "";
      _treatmentDetailController.text =
          treatment.treatmentDetail?.toString() ?? "";
      _vetNameController.text = treatment.doctorName?.toString() ?? "";
      _drugNameController.text = treatment.medicineName?.toString() ?? "";
      _notesController.text = treatment.memo?.toString() ?? "";

      if (treatment.attachedFiles != null &&
          treatment.attachedFiles!.isNotEmpty) {
        _attachedFiles = treatment.attachedFiles!;
      }
    }
  }

  bool _validateForm() {
    return _form.currentState?.validate() ?? false;
  }

  void _addTreatment(BuildContext context) async {
    if (!_validateForm()) {
      await showOkDialog(context, "Error", "Please enter required fields.");
      return;
    }

    var treatmentsProvider = Provider.of<Treatments>(context, listen: false);
    var selectedHorse = context.read<Treatments>().selectedHorse;

    if (selectedHorse == null) return;

    _setLoading(true);
    var getTreatmentResponse = await treatmentsProvider.addTreatment(
      horseId: selectedHorse.id!,
      date: _dateController.text,
      vetName: _vetNameController.text,
      treatmentDetail: _treatmentDetailController.text,
      injuredPart: _injuredPartcontroller.text,
      occasionType: _occasionType ?? "",
      medicineName: _drugNameController.text,
      memo: _notesController.text,
      treatmentAttachedIds:
          attachedFiles.map((attached) => attached.id.toString()).toList(),
      uploadedFiles: _uploadedFiles,
      id: widget.treatment?.id,
    );
    _setLoading(false);

    MetaResponse metaResponse = getTreatmentResponse.metaResponse;

    var message = widget.treatment == null
        ? "Treatment Successfully created!"
        : "Treatment Successfully updated!";

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
    return Form(
      key: _form,
      child: Column(
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
            isRequired: true,
            focusNode: _dateFocusNode,
          ),
          SizedBox(
            height: 16,
          ),
          InbloDropdownTextField(
            onChanged: (value) {
              _occasionType = value;
            },
            items: ["", ...occasionTypeChoice]
                .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                .toList(),
            textHint: "分類*", // Occasion Type
            value: _occasionType,
            isRequired: true,
            validator: AppConstants.requireCallback,
          ),
          SizedBox(
            height: 16,
          ),
          InbloTextField(
            textHint: "故障箇所", // injured part
            controller: _injuredPartcontroller,
          ),
          SizedBox(
            height: 16,
          ),
          InbloTextField(
            textHint: "治療内容", // treatment detail
            controller: _treatmentDetailController,
          ),
          SizedBox(
            height: 16,
          ),
          InbloTextField(
            textHint: "獣医名", // vet name
            controller: _vetNameController,
          ),
          SizedBox(
            height: 16,
          ),
          InbloTextField(
            textHint: "薬品名", // drug name
            controller: _drugNameController,
          ),
          SizedBox(
            height: 16,
          ),
          InbloTextField(
            textHint: "メモを書く...", // notes
            maxLines: 6,
            controller: _notesController,
          ),
          SizedBox(
            height: 16,
          ),
          AttachmentsBox(
            viewDir: AttachmentDir.treatments,
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
                  onPressed: () => _addTreatment(context),
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
    _dateFocusNode.dispose();
    _dateController.dispose();
    _injuredPartcontroller.dispose();
    _treatmentDetailController.dispose();
    _vetNameController.dispose();
    _drugNameController.dispose();
    _notesController.dispose();
    super.dispose();
  }
}
