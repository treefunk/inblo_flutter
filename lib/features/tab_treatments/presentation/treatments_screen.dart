import 'package:flutter/material.dart';
import 'package:inblo_app/common_widgets/general_dialog.dart';
import 'package:inblo_app/common_widgets/inblo_white_rounded_button.dart';
import 'package:inblo_app/common_widgets/table_column_label.dart';
import 'package:inblo_app/features/horse_details/file_attachments/attached_dialog.dart';
import 'package:inblo_app/models/treatment.dart';
import 'package:inblo_app/util/inblo_desktop_scroll_behavior.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_theme.dart';
import '../providers/treatments.dart';
import 'add_treatment_dialog.dart';

class TreatmentsScreen extends StatefulWidget {
  const TreatmentsScreen({super.key});

  @override
  State<TreatmentsScreen> createState() => _TreatmentsScreenState();
}

class _TreatmentsScreenState extends State<TreatmentsScreen> {
  late LinkedScrollControllerGroup _linkedScrollControllerGroup;
  late ScrollController _columnsScrollController;
  late ScrollController _dataTableScrollController;

  late final Future getTreatmentsFuture;

  @override
  void initState() {
    _linkedScrollControllerGroup = LinkedScrollControllerGroup();
    _columnsScrollController = _linkedScrollControllerGroup.addAndGet();
    _dataTableScrollController = _linkedScrollControllerGroup.addAndGet();

    getTreatmentsFuture = _getTreatmentsFuture();

    super.initState();
  }

  Future<void> _getTreatmentsFuture() async {
    var treatmentsProvider = Provider.of<Treatments>(context, listen: false);
    await treatmentsProvider.fetchTreatments();
  }

  @override
  Widget build(BuildContext context) {
    print("build treatments");
    return FutureBuilder(
        future: getTreatmentsFuture,
        builder: (context, snapshot) {
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
              var treatments = context.watch<Treatments>().treatments;

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
                                  title: "治療内容",
                                  content: (ctx) => AddTreatmentDialog(),
                                );
                              },
                              title: "内容を記録する",
                              iconPrefix: Icons.add,
                            )),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                  if (treatments.isNotEmpty)
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
                          // label_date,label_occasion_type,label_injured_part,label_treatment_detail
                          // ,label_vet_name,label_drug_name,label_note,label_attachments"
                          child: Row(
                            children: [
                              SizedBox(width: 50),
                              TableColumnLabel(title: "日付"), //date
                              TableColumnLabel(title: "分類"), //occasion type
                              TableColumnLabel(title: "故障箇所"), // injured part
                              TableColumnLabel(
                                  title: "治療内容"), // treatment detail
                              TableColumnLabel(title: "獣医名"), // vet name
                              TableColumnLabel(title: "投与薬品名"), // drug name
                              TableColumnLabel(title: "治療メモ"), // notes
                              TableColumnLabel(title: "添付ファイル"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  if (treatments.isNotEmpty)
                    Flexible(
                      child: ScrollConfiguration(
                        behavior: InbloDesktopScrollBehavior(),
                        child: SingleChildScrollView(
                          controller: _dataTableScrollController,
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          child: Container(
                              // height: constraints.maxHeight
                              width:
                                  866, // 50 first col / 8 + 8 padding / 800 per col
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              color: Colors.white,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemCount: treatments.length,
                                itemBuilder: ((ctx, index) => ItemTreatment(
                                      treatment: treatments[index],
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

class ItemTreatment extends StatefulWidget {
  const ItemTreatment({
    required this.treatment,
    Key? key,
  }) : super(key: key);

  final Treatment treatment;

  @override
  State<ItemTreatment> createState() => _ItemTreatmentState();
}

class _ItemTreatmentState extends State<ItemTreatment> {
  void _deleteTreatment(BuildContext context, int treatmentId) async {
    bool wantDelete = await showConfirmationDialog(
        context, "Confirm", "Are you sure you to delete this?");

    if (mounted && wantDelete) {
      Provider.of<Treatments>(
        context,
        listen: false,
      ).removeTreatment(treatmentId);
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
                        title: "治療内容",
                        content: (ctx) => AddTreatmentDialog(
                          treatment: widget.treatment,
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
                        _deleteTreatment(context, widget.treatment.id!),
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
              title: widget.treatment.formattedDate?.toString() ?? ""), //date
          TableValueLabel(
              title: widget.treatment.occasionType?.toString() ??
                  ""), //occasion type
          TableValueLabel(
              title: widget.treatment.injuredPart?.toString() ??
                  ""), // injured part
          TableValueLabel(
              title: widget.treatment.treatmentDetail?.toString() ??
                  ""), // condition group
          TableValueLabel(
              title:
                  widget.treatment.doctorName?.toString() ?? ""), // rider name
          TableValueLabel(
              title: widget.treatment.medicineName?.toString() ??
                  ""), // training type
          TableValueLabel(title: widget.treatment.memo ?? ""), // notes/memo
          if (widget.treatment.attachedFiles != null &&
              widget.treatment.attachedFiles!.isNotEmpty)
            GestureDetector(
                onTap: () {
                  //todo
                  showCustomDialog(
                    context: context,
                    title: "",
                    content: (ctx) => AttachedDialog.fromTreatments(
                        widget.treatment.attachedFiles!),
                  );
                },
                child: TableValueLabel(title: "ファイル")), //
        ],
      ),
    );
  }
}
