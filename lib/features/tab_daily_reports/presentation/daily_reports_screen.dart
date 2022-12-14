import 'package:flutter/material.dart';
import 'package:inblo_app/features/horse_details/file_attachments/attached_dialog.dart';
import 'package:inblo_app/common_widgets/general_dialog.dart';
import 'package:inblo_app/common_widgets/inblo_white_rounded_button.dart';
import 'package:inblo_app/common_widgets/table_column_label.dart';
import 'package:inblo_app/constants/app_theme.dart';
import 'package:inblo_app/features/tab_daily_reports/presentation/add_daily_report_dialog.dart';
import 'package:inblo_app/features/tab_daily_reports/providers/daily_reports.dart';
import 'package:inblo_app/models/daily_report.dart';
import 'package:inblo_app/util/inblo_desktop_scroll_behavior.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:provider/provider.dart';

class DailyReportsScreen extends StatefulWidget {
  const DailyReportsScreen({
    super.key,
  });

  @override
  State<DailyReportsScreen> createState() => _DailyReportsScreenState();
}

class _DailyReportsScreenState extends State<DailyReportsScreen> {
  late LinkedScrollControllerGroup _linkedControllerGroup;
  late ScrollController _columnsScrollController;
  late ScrollController _dataTableScrollController;
  final _columnKey = GlobalKey();

  late final Future getDailyReportsFuture;

  Future<void> _getDailyReportData() async {
    var dailyReportProvider = Provider.of<DailyReports>(context, listen: false);

    await dailyReportProvider.fetchDailyReports();
    await dailyReportProvider.initDailyReportDropdown();
  }

  @override
  void initState() {
    _linkedControllerGroup = LinkedScrollControllerGroup();
    _columnsScrollController = _linkedControllerGroup.addAndGet();
    _dataTableScrollController = _linkedControllerGroup.addAndGet();
    getDailyReportsFuture = _getDailyReportData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("build daily report screen");
    return FutureBuilder(
        future: getDailyReportsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.error != null) {
              print(snapshot.error.toString());
              return Center(
                child: Text("Something went wrong. Please try again."),
              );
            } else {
              var dailyReports = context.watch<DailyReports>().dailyReports;

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
                                  content: (ctx) => AddDailyReportDialog(),
                                );
                              },
                              title: "状態を記録する",
                              iconPrefix: Icons.add,
                            )),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                  if (dailyReports.isNotEmpty)
                    ScrollConfiguration(
                      behavior: InbloDesktopScrollBehavior(),
                      child: SingleChildScrollView(
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
                              TableColumnLabel(
                                  title: "馬場状態"), // condition group
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
                    ),
                  if (dailyReports.isNotEmpty)
                    Flexible(
                      child: ScrollConfiguration(
                        behavior: InbloDesktopScrollBehavior(),
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
                                itemCount: dailyReports.length,
                                itemBuilder: ((ctx, index) => ItemDailyReport(
                                      dailyReport: dailyReports[index],
                                    )),
                              )),
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
        });
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

class ItemDailyReport extends StatefulWidget {
  const ItemDailyReport({
    required this.dailyReport,
    Key? key,
  }) : super(key: key);

  final DailyReport dailyReport;

  @override
  State<ItemDailyReport> createState() => _ItemDailyReportState();
}

class _ItemDailyReportState extends State<ItemDailyReport> {
  void _deleteDailyReport(BuildContext context, int dailyReportId) async {
    bool wantDelete = await showConfirmationDialog(
        context, "Confirm", "Are you sure you to delete this?");

    if (mounted && wantDelete) {
      Provider.of<DailyReports>(
        context,
        listen: false,
      ).removeDailyReport(dailyReportId);
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
                        title: "状態入力",
                        content: (ctx) => AddDailyReportDialog(
                          dailyReport: widget.dailyReport,
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
                    onTap: () =>
                        _deleteDailyReport(context, widget.dailyReport.id!),
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

          TableValueLabel(
              title: widget.dailyReport.formattedDate?.toString() ?? ""), //date
          TableValueLabel(
              title: widget.dailyReport.bodyTemperature?.toString() ??
                  ""), //temperature
          TableValueLabel(
              title:
                  widget.dailyReport.horseWeight?.toString() ?? ""), // weight
          TableValueLabel(
              title: widget.dailyReport.conditionGroup!), // condition group
          TableValueLabel(
              title: widget.dailyReport.rider?.name ?? ""), // rider name
          TableValueLabel(
              title:
                  widget.dailyReport.trainingType?.name ?? ""), // training type
          TableValueLabel(
              title:
                  widget.dailyReport.trainingAmount ?? ""), // training amount
          TableValueLabel(title: widget.dailyReport.time5f?.toString() ?? ""),
          TableValueLabel(title: widget.dailyReport.time4f?.toString() ?? ""),
          TableValueLabel(title: widget.dailyReport.time3f?.toString() ?? ""),
          TableValueLabel(title: widget.dailyReport.memo ?? ""), // notes/memo
          if (widget.dailyReport.attachedFiles != null &&
              widget.dailyReport.attachedFiles!.isNotEmpty)
            GestureDetector(
                onTap: () {
                  showCustomDialog(
                    context: context,
                    title: "",
                    content: (ctx) => AttachedDialog.fromDailyReport(
                        widget.dailyReport.attachedFiles!),
                  );
                },
                child: TableValueLabel(title: "ファイル")), //
        ],
      ),
    );
  }
}
