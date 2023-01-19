import 'package:flutter/material.dart';
import 'package:inblo_app/common_widgets/general_dialog.dart';
import 'package:inblo_app/common_widgets/table_column_label.dart';
import 'package:inblo_app/constants/app_theme.dart';
import 'package:inblo_app/features/messages/presentation/add_message_dialog.dart';
import 'package:inblo_app/features/messages/provider/messages.dart';
import 'package:inblo_app/models/message.dart';
import 'package:inblo_app/models/user_details.dart';
import 'package:provider/provider.dart';

class ItemMessage extends StatefulWidget {
  ItemMessage({
    required this.message,
    this.visibleActions = false,
    Key? key,
  }) : super(key: key);

  final Message message;
  bool visibleActions;

  @override
  State<ItemMessage> createState() => _ItemMessageState();
}

class _ItemMessageState extends State<ItemMessage> {
  void _deleteMessage(BuildContext context, int messageId) async {
    bool wantDelete = await showConfirmationDialog(
        context, "Confirm", "Are you sure you want to delete this?");

    if (mounted && wantDelete) {
      Provider.of<Messages>(
        context,
        listen: false,
      ).removeMessage(messageId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.2,
            color: colorPrimaryDark,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.visibleActions)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  SizedBox(width: 3),
                  Material(
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () {
                        showCustomDialog(
                          context: context,
                          title: "メッセージを作成する",
                          content: (ctx) => AddMessageDialog(
                            message: widget.message,
                          ),
                        );
                      },
                      child: Icon(
                        Icons.edit_note,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(width: 4),
                  Material(
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () => _deleteMessage(context, widget.message.id!),
                      child: Icon(
                        Icons.delete,
                        color: Colors.red[900],
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(width: 3),
                ],
              ),
            ),
          if (!widget.visibleActions)
            SizedBox(
              width: 50,
            ),

          TableValueLabel(
              title: widget.message.formattedDate?.toString() ?? ""), //date
          TableValueLabel(
              title: widget.message.formattedTime?.toString() ?? ""), //time
          TableValueLabel(
              title: widget.message.sender?.username?.toString() ?? ""), // from
          TableValueLabel(
              title:
                  widget.message.recipient?.username?.toString() ?? "全員"), // to
          TableValueLabel(
              title: widget.message.title?.toString() ?? ""), // title
          TableValueLabel(
              title: widget.message.notificationType?.toString() ?? ""), // type
          TableValueLabel(
              title: widget.message.horseName?.toString() ?? ""), // horse name

          TableValueLabel(title: widget.message.memo ?? ""), // notes/memo
        ],
      ),
    );
  }
}
