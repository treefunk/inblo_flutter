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

enum DailyReportColumns {
  editDeleteButtons("", "", 50.0),
  date("date", "日付", 100.0),
  temperature("body_temperature", "体温", 100.0),
  horseWeight("horse_weight", "馬体重", 100.0),
  conditionGroup("condition_group", "馬場状態", 100.0),
  rider("rider", "乗り手", 100.0),
  trainingType("training_type", "調教内容", 100.0),
  trainingAmount("training_amount", "調教量", 100.0),
  time_5f("5f_time", "5F", 100.0),
  time_4f("4f_time", "4F", 100.0),
  time_3f("3f_time", "3F", 100.0),
  notes("memo", "メモ", 100.0),
  attachments("attachments", "添付ファイル", 100.0);

  final String field;
  final String label;
  final double width;

  const DailyReportColumns(this.field, this.label, this.width);
}

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

  late final Future getDailyReportsFuture;

  List<DailyReportColumns> _getActiveColumns(List<String> hiddenColumns) {
    List<DailyReportColumns> columns = [];
    for (var col in DailyReportColumns.values) {
      if (!hiddenColumns.contains(col.field)) {
        columns.add(col);
      }
    }
    return columns;
  }

  @override
  void initState() {
    _linkedControllerGroup = LinkedScrollControllerGroup();
    _columnsScrollController = _linkedControllerGroup.addAndGet();
    _dataTableScrollController = _linkedControllerGroup.addAndGet();
    getDailyReportsFuture = _getDailyReportData();

    super.initState();
  }

  Future<void> _getDailyReportData() async {
    var dailyReportProvider = Provider.of<DailyReports>(context, listen: false);

    await dailyReportProvider.fetchDailyReports();
    await dailyReportProvider.initDailyReportDropdown();
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
              var dailyReportsProvider = context.watch<DailyReports>();
              var dailyReports = dailyReportsProvider.dailyReports;
              var hiddenColumns = dailyReportsProvider.hiddenColumns;

              print(hiddenColumns);
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
                        physics: BouncingScrollPhysics(),
                        child: Container(
                          // width: 1266,
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
                              ..._getActiveColumns(hiddenColumns).map(
                                (col) => TableColumnLabel(title: col.label),
                              )
                              // TableColumnLabel(title: "日付"), //date
                              // TableColumnLabel(title: "体温"), //temperature
                              // TableColumnLabel(title: "馬体重"), // weight
                              // TableColumnLabel(
                              //     title: "馬場状態"), // condition group
                              // TableColumnLabel(title: "乗り手"), // rider name
                              // TableColumnLabel(title: "調教内容"), // training type
                              // TableColumnLabel(title: "調教量"), // training amount
                              // TableColumnLabel(title: "5F"),
                              // TableColumnLabel(title: "4F"),
                              // TableColumnLabel(title: "3F"),
                              // TableColumnLabel(title: "メモ"), // notes/memo
                              ,
                              // TableColumnLabel(title: "添付ファイル"), // attachments
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
                          physics: BouncingScrollPhysics(),
                          child: Container(
                              // height: constraints.maxHeight

                              width: 66 +
                                  ((DailyReportColumns.values.length * 100) -
                                      (hiddenColumns.length * 100)),
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              color: Colors.white,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemCount: dailyReports.length,
                                itemBuilder: ((ctx, index) => ItemDailyReport(
                                      dailyReport: dailyReports[index],
                                      hiddenColumns: hiddenColumns,
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

// class DailyReportsColumn extends StatelessWidget {
//   const DailyReportsColumn({
//     Key? key,
//     required ScrollController columnsScrollController,
//   })  : _columnsScrollController = columnsScrollController,
//         super(key: key);

//   final ScrollController _columnsScrollController;

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       controller: _columnsScrollController,
//       child: Container(
//         margin: EdgeInsets.symmetric(horizontal: 8),
//         padding: EdgeInsets.symmetric(horizontal: 8),
//         decoration: BoxDecoration(
//           color: colorPrimaryDark,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(10),
//             topRight: Radius.circular(10),
//           ),
//         ),
//         child: Row(
//           children: [
//             SizedBox(width: 50),
//             TableColumnLabel(title: "日付"), //date
//             TableColumnLabel(title: "体温"), //temperature
//             TableColumnLabel(title: "馬体重"), // weight
//             TableColumnLabel(title: "馬場状態"), // condition group
//             TableColumnLabel(title: "乗り手"), // rider name
//             TableColumnLabel(title: "調教内容"), // training type
//             TableColumnLabel(title: "調教量"), // training amount
//             TableColumnLabel(title: "5F"),
//             TableColumnLabel(title: "4F"),
//             TableColumnLabel(title: "3F"),
//             TableColumnLabel(title: "メモ"), // notes/memo
//             TableColumnLabel(title: "添付ファイル"), // attachments
//           ],
//         ),
//       ),
//     );
//   }
// }

class ItemDailyReport extends StatefulWidget {
  ItemDailyReport({
    required this.dailyReport,
    required this.hiddenColumns,
    Key? key,
  }) : super(key: key);

  final DailyReport dailyReport;
  final List<String> hiddenColumns;

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

  bool _ifNotFiltered(String field) {
    return !widget.hiddenColumns.contains(field);
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
          if (_ifNotFiltered("date"))
            TableValueLabel(
                title:
                    widget.dailyReport.formattedDate?.toString() ?? ""), //date
          if (_ifNotFiltered("body_temperature"))
            TableValueLabel(
                title: widget.dailyReport.bodyTemperature?.toString() ??
                    ""), //temperature
          if (_ifNotFiltered("horse_weight"))
            TableValueLabel(
                title: widget.dailyReport.horseWeight?.toString() ?? ""),
          if (_ifNotFiltered("condition_group"))
            // weight
            TableValueLabel(
                title: widget.dailyReport.conditionGroup!), // condition group
          if (_ifNotFiltered("rider"))
            TableValueLabel(
                title: widget.dailyReport.rider?.name ?? ""), // rider name
          if (_ifNotFiltered("training_type"))
            TableValueLabel(
                title: widget.dailyReport.trainingType?.name ??
                    ""), // training type
          if (_ifNotFiltered("training_amount"))
            TableValueLabel(title: widget.dailyReport.trainingAmount ?? ""),
          if (_ifNotFiltered("5f_time"))
            TableValueLabel(title: widget.dailyReport.time5f?.toString() ?? ""),
          if (_ifNotFiltered("4f_time"))
            TableValueLabel(title: widget.dailyReport.time4f?.toString() ?? ""),
          if (_ifNotFiltered("3f_time"))
            TableValueLabel(title: widget.dailyReport.time3f?.toString() ?? ""),
          if (_ifNotFiltered("memo"))
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
