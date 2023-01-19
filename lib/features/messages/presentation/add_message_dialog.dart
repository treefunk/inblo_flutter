import 'package:flutter/material.dart';
import 'package:inblo_app/common_widgets/general_dialog.dart';
import 'package:inblo_app/common_widgets/inblo_text_button.dart';
import 'package:inblo_app/common_widgets/inblo_text_field.dart';
import 'package:inblo_app/constants/text_styles.dart';
import 'package:inblo_app/features/horse_list/providers/horses.dart';
import 'package:inblo_app/features/horse_list/providers/persons_in_charge.dart';
import 'package:inblo_app/features/messages/api/get_message_response.dart';
import 'package:inblo_app/features/messages/provider/messages.dart';
import 'package:inblo_app/models/dropdown_data.dart';

import 'package:inblo_app/models/message.dart';
import 'package:inblo_app/models/meta_response.dart';
import 'package:provider/provider.dart';

enum RecipientType {
  everyone(0),
  recipient(1);

  final int notificationNum;
  const RecipientType(this.notificationNum);
}

class AddMessageDialog extends StatefulWidget {
  AddMessageDialog({super.key, this.message});

  Message? message;

  @override
  State<AddMessageDialog> createState() => _AddMessageDialogState();
}

class _AddMessageDialogState extends State<AddMessageDialog> {
  final _titleController = TextEditingController();

  late RecipientType _recipientType = RecipientType.everyone;

  int? _userId;
  int? _horseId;

  bool _isLoading = false;

  final List<String> notificationTypeChoices = [
    "関係者連絡",
    "状態関連",
    "出走予定",
    "調教相談",
    "厩舎行事",
    "その他",
  ];

  String _notificationType = "";

  final _memoController = TextEditingController();

  final _form = GlobalKey<FormState>();

  @override
  void initState() {
    _recipientType = RecipientType.everyone;

    super.initState();
    print("init add message");

    initFields();
  }

  void initFields() {
    if (widget.message != null) {
      var message = widget.message!;
      _titleController.text = message.title ?? "";
      _notificationType = message.notificationType ?? "";
      _recipientType = message.recipient == null
          ? RecipientType.everyone
          : RecipientType.recipient;

      if (_recipientType == RecipientType.recipient) {
        _userId = message.recipientId;
      }

      _horseId = message.horseId;
      _memoController.text = message.memo ?? "";
    }
  }

  bool _validateForm() {
    return _form.currentState?.validate() ?? false;
  }

  void _addMessage(BuildContext context) async {
    if (!_validateForm()) {
      await showOkDialog(context, "Error", "Please enter required fields.");
      return;
    }

    var messagesProvider = Provider.of<Messages>(context, listen: false);
    var horseProvider = Provider.of<Horses>(context, listen: false);

    String horseName = "";
    if (_horseId != null) {
      horseName = horseProvider.getHorseById(_horseId!).name!;
    }

    print(horseName);

    int? recipientId = _userId ?? 0;

    if (_recipientType == RecipientType.everyone) {
      recipientId = 0;
    }

    _setLoading(true);
    GetMessageResponse getMessageResponse = await messagesProvider.addMessage(
      recipientId: recipientId,
      horseId: _horseId,
      horseName: horseName,
      notificationType: _notificationType,
      title: _titleController.text,
      memo: _memoController.text,
      isRead: "0",
      id: widget.message?.id,
    );
    _setLoading(false);

    MetaResponse metaResponse = getMessageResponse.metaResponse;

    var message = widget.message == null
        ? "Message Successfully created!"
        : "Message Successfully updated!";
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
          InbloTextField(
            textHint: "通知タイトル*", //title
            controller: _titleController,
            isRequired: true,
          ),
          SizedBox(
            height: 12,
          ),
          InbloDropdownTextField(
            onChanged: (value) {
              _notificationType = value;
            },
            items: ["", ...notificationTypeChoices]
                .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                .toList(),
            textHint: "通知タイプ*", // notification type
            value: _notificationType,
            isRequired: true,
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: ListTile(
                  title: const Text(
                    '全員', // Everyone
                    style: TextStyle(fontFamily: "Roboto", fontSize: 16),
                  ),
                  leading: Radio<RecipientType>(
                    value: RecipientType.everyone,
                    groupValue: _recipientType,
                    onChanged: (RecipientType? value) {
                      setState(() {
                        if (value != null) _recipientType = value;
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: const Text('ユーザー名"', // Username
                      style: TextStyle(fontFamily: "Roboto", fontSize: 16)),
                  leading: Radio<RecipientType>(
                    value: RecipientType.recipient,
                    groupValue: _recipientType,
                    onChanged: (RecipientType? value) {
                      setState(() {
                        _userId = null;
                        if (value != null) _recipientType = value;
                      });
                    },
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 12,
          ),
          if (_recipientType == RecipientType.recipient)
            Consumer<Users>(
              builder: ((ctx, dropdown, child) => InbloDropdownTextField(
                    onChanged: (value) {
                      if (value.toString().isNotEmpty) {
                        _userId = value;
                      } else {
                        _userId = null;
                      }
                    },
                    items: [
                      DropdownData(id: null, name: ""),
                      ...dropdown.userRecipients
                    ]
                        .map((p) => DropdownMenuItem(
                            value: p.id, child: Text(p.name ?? "")))
                        .toList(),
                    textHint: "ユーザー名*", // recipient
                    value: _userId,
                    validator: (value) {
                      if (value == null) {
                        return "This field is required.";
                      }
                    },
                  )),
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
                  items: [
                    DropdownData(),
                    ...dropdown.horses
                        .map((h) => DropdownData(id: h.id, name: h.name))
                  ]
                      .map((p) => DropdownMenuItem(
                          value: p.id, child: Text(p.name ?? "")))
                      .toList(),
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
                  onPressed: () => _addMessage(context),
                  title: "＋ メッセージを作成する",
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
    _titleController.dispose();
    _memoController.dispose();
    super.dispose();
  }
}
