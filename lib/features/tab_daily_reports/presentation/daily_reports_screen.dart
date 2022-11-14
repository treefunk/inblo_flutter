import 'package:flutter/material.dart';
import 'package:inblo_app/common_widgets/general_dialog.dart';
import 'package:inblo_app/common_widgets/inblo_white_rounded_button.dart';
import 'package:inblo_app/common_widgets/table_column_label.dart';
import 'package:inblo_app/constants/app_theme.dart';
import 'package:inblo_app/features/tab_daily_reports/presentation/add_daily_report_dialog.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

class DailyReportsScreen extends StatefulWidget {
  const DailyReportsScreen({super.key});

  @override
  State<DailyReportsScreen> createState() => _DailyReportsScreenState();
}

class _DailyReportsScreenState extends State<DailyReportsScreen> {
  late LinkedScrollControllerGroup _linkedControllerGroup;
  late ScrollController _columnsScrollController;
  late ScrollController _dataTableScrollController;
  final _columnKey = GlobalKey();

  @override
  void initState() {
    _linkedControllerGroup = LinkedScrollControllerGroup();
    _columnsScrollController = _linkedControllerGroup.addAndGet();
    _dataTableScrollController = _linkedControllerGroup.addAndGet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            children: [
              Container(
                height: 35,
                width: double.infinity,
                child: InbloWhiteRoundedButton(
                  onPressed: () {
                    showCustomDialog(
                      context: context,
                      title: "状態入力",
                      content: AddDailyReportDialog(),
                    );
                  },
                  title: "状態を記録する",
                  iconPrefix: Icons.add,
                ),
              ),
              SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: _columnsScrollController,
          child: Container(
            width: 1266,
            margin: EdgeInsets.symmetric(horizontal: 8),
            padding: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: colorPrimaryDark,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Row(
              children: [
                SizedBox(width: 50),
                TableColumnLabel(title: "日付"), //date
                TableColumnLabel(title: "体温"), //temperature
                TableColumnLabel(title: "馬体重"), // weight
                TableColumnLabel(title: "馬場状態"), // condition group
                TableColumnLabel(title: "乗り手"), // rider name
                TableColumnLabel(title: "調教内容"), // training type
                TableColumnLabel(title: "調教量"), // training amount
                TableColumnLabel(title: "5F"),
                TableColumnLabel(title: "4F"),
                TableColumnLabel(title: "3F"),
                TableColumnLabel(title: "メモ"), // notes/memo
                TableColumnLabel(title: "添付ファイル"), // attachments
              ],
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            controller: _dataTableScrollController,
            scrollDirection: Axis.horizontal,
            child: Container(
                // height: constraints.maxHeight
                width: 1266,
                margin: EdgeInsets.symmetric(horizontal: 8),
                color: Colors.white,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: 30,
                  itemBuilder: ((ctx, index) => ItemDailyReport()),
                )
                // child: Column(
                //   children: [
                //     ItemDailyReport(),
                //     ItemDailyReport(),
                //     ItemDailyReport(),
                //     ItemDailyReport(),
                //     ItemDailyReport(),
                //     ItemDailyReport(),
                //     ItemDailyReport(),
                //   ],
                // ),
                ),
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}

class DailyReportsColumn extends StatelessWidget {
  const DailyReportsColumn({
    Key? key,
    required ScrollController columnsScrollController,
  })  : _columnsScrollController = columnsScrollController,
        super(key: key);

  final ScrollController _columnsScrollController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: _columnsScrollController,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        padding: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: colorPrimaryDark,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Row(
          children: [
            SizedBox(width: 50),
            TableColumnLabel(title: "日付"), //date
            TableColumnLabel(title: "体温"), //temperature
            TableColumnLabel(title: "馬体重"), // weight
            TableColumnLabel(title: "馬場状態"), // condition group
            TableColumnLabel(title: "乗り手"), // rider name
            TableColumnLabel(title: "調教内容"), // training type
            TableColumnLabel(title: "調教量"), // training amount
            TableColumnLabel(title: "5F"),
            TableColumnLabel(title: "4F"),
            TableColumnLabel(title: "3F"),
            TableColumnLabel(title: "メモ"), // notes/memo
            TableColumnLabel(title: "添付ファイル"), // attachments
          ],
        ),
      ),
    );
  }
}

class ItemDailyReport extends StatelessWidget {
  const ItemDailyReport({
    Key? key,
  }) : super(key: key);

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
        children: [
          TableValueLabel.onlyWidth(50),
          TableValueLabel(title: "添付ファイル"),
          TableValueLabel(title: "添付ファイル"),
          TableValueLabel(title: "添付ファイル"),
          TableValueLabel(title: "添付ファイル"),
          TableValueLabel(title: "添付ファイル"),
          TableValueLabel(title: "添付ファイル"),
          TableValueLabel(title: "添付ファイル"),
          TableValueLabel(title: "添付ファイル"),
          TableValueLabel(title: "添付ファイル"),
          TableValueLabel(title: "添付ファイル"),
          TableValueLabel(title: "添付ファイル"),
          TableValueLabel(title: "添付ファイル"),
        ],
      ),
    );
  }
}
