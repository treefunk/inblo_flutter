import 'package:flutter/material.dart';
import 'package:inblo_app/common_widgets/table_column_label.dart';
import 'package:inblo_app/constants/app_theme.dart';
import 'package:inblo_app/features/messages/presentation/item_message.dart';
import 'package:inblo_app/features/messages/provider/messages.dart';
import 'package:inblo_app/models/user_details.dart';
import 'package:inblo_app/util/inblo_desktop_scroll_behavior.dart';
import 'package:inblo_app/util/preference_utils.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:provider/provider.dart';

class MessageList extends StatefulWidget {
  const MessageList({super.key});

  @override
  State<MessageList> createState() => MessageListState();
}

class MessageListState extends State<MessageList> {
  late LinkedScrollControllerGroup _linkedScrollControllerGroup;
  late ScrollController _columnsScrollController;
  late ScrollController _dataTableScrollController;

  late final Future getMessagesFuture;
  late UserDetails _userDetails;

  @override
  void initState() {
    _linkedScrollControllerGroup = LinkedScrollControllerGroup();
    _columnsScrollController = _linkedScrollControllerGroup.addAndGet();
    _dataTableScrollController = _linkedScrollControllerGroup.addAndGet();

    getMessagesFuture = _getMessagesFuture();

    super.initState();
  }

  Future<void> _getMessagesFuture() async {
    var messagesProvider = Provider.of<Messages>(context, listen: false);
    await messagesProvider.fetchMessages();
    _userDetails = await PreferenceUtils.getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getMessagesFuture,
        builder: (context, snapshot) {
          {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.error != null) {
                print("snapshot error.");

                print(snapshot.error.toString());
                return Center(
                  child: Text("Something went wrong. Please try again."),
                );
              } else {
                var messages = context.watch<Messages>().messages;

                return Expanded(
                  child: LayoutBuilder(builder: (context, constraints) {
                    return SingleChildScrollView(
                      child: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            if (messages.isNotEmpty)
                              Container(
                                height: 50,
                                child: ScrollConfiguration(
                                  behavior: InbloDesktopScrollBehavior(),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    controller: _columnsScrollController,
                                    physics: BouncingScrollPhysics(),
                                    child: Container(
                                      // width: 1266,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      decoration: BoxDecoration(
                                        color: colorPrimaryDark,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        ),
                                      ),
                                      // label_date,label_occasion_type,label_injured_part,label_treatment_detail
                                      // ,label_vet_name,label_drug_name,label_note,label_attachments"
                                      child: Row(
                                        children: [
                                          SizedBox(width: 50),
                                          TableColumnLabel(title: "日付"), //date
                                          TableColumnLabel(title: "時間"), //time
                                          TableColumnLabel(
                                              title: "From"), // from
                                          TableColumnLabel(title: "To"), // to
                                          TableColumnLabel(
                                              title: "通知タイトル"), // title
                                          TableColumnLabel(
                                              title: "通知タイプ"), // type
                                          TableColumnLabel(
                                              title: "馬名"), // horse name
                                          TableColumnLabel(title: "メモ"), // note
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            if (messages.isNotEmpty)
                              Container(
                                constraints: BoxConstraints(minHeight: 0),
                                child: ScrollConfiguration(
                                  behavior: InbloDesktopScrollBehavior(),
                                  child: SingleChildScrollView(
                                    controller: _dataTableScrollController,
                                    scrollDirection: Axis.horizontal,
                                    physics: BouncingScrollPhysics(),
                                    child: Container(
                                        // height: constraints.maxHeight
                                        width:
                                            866, // 50 first col / 8 + 8 padding / 100 per col
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 8),
                                        color: Colors.white,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          physics: BouncingScrollPhysics(),
                                          itemCount: messages.length,
                                          itemBuilder: ((ctx, index) =>
                                              ItemMessage(
                                                message: messages[index],
                                                visibleActions: _userDetails
                                                        .userId ==
                                                    messages[index].senderId,
                                              )),
                                        )),
                                  ),
                                ),
                              ),
                            SizedBox(
                              height: 16,
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                );
              }
            }
          }
        });
  }
}
