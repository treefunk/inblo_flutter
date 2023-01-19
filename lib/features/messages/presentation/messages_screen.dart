import 'package:flutter/material.dart';
import 'package:inblo_app/common_widgets/general_dialog.dart';
import 'package:inblo_app/common_widgets/inblo_sub_header.dart';
import 'package:inblo_app/common_widgets/inblo_text_button.dart';
import 'package:inblo_app/common_widgets/table_column_label.dart';
import 'package:inblo_app/constants/app_theme.dart';
import 'package:inblo_app/features/horse_list/providers/persons_in_charge.dart';
import 'package:inblo_app/features/messages/presentation/add_message_dialog.dart';
import 'package:inblo_app/features/messages/presentation/message_list.dart';
import 'package:inblo_app/features/messages/provider/messages.dart';
import 'package:inblo_app/models/message.dart';
import 'package:inblo_app/util/inblo_desktop_scroll_behavior.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:provider/provider.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

// 新規メッセージ
class _MessagesScreenState extends State<MessagesScreen> {
  late final Future getUsersFuture;

  @override
  void initState() {
    getUsersFuture = Provider.of<Users>(context, listen: false).fetchUsers(
      forMessageRecipients: true,
      excludeAuthUser: true,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorDarkBackground,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          InbloSubHeader(
            title: "管理馬一覧",
            trailing: FutureBuilder(
                future: getUsersFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return InbloTextButton(
                      onPressed: () {
                        showCustomDialog(
                          context: context,
                          title: "メッセージを作成する",
                          content: (ctx) => AddMessageDialog(),
                        );
                      },
                      title: "メッセージ",
                      padding: 0,
                      textStyle: TextStyleInbloButton.medium,
                      iconPrefix: Icon(
                        Icons.send,
                        size: 18,
                        color: Colors.white,
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
          SizedBox(
            height: 12,
          ),
          MessageList(),
        ],
      ),
    );
  }
}
