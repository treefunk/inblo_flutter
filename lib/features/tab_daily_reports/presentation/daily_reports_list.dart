import 'package:flutter/material.dart';

class DailyReportsList extends StatelessWidget {
  // Function() onEdit;
  // Function() onDelete;
  // Function()
  final List<Widget> children;
  final ScrollController scrollController;

  const DailyReportsList({
    required this.children,
    required this.scrollController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      scrollDirection: Axis.horizontal,
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          color: Colors.white,
          child: ListView.builder(
            itemBuilder: ((context, index) => Text("fdsfs")),
            itemCount: 10,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
          )),
    );
  }
}
