import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:inblo_app/constants/app_theme.dart';
import 'package:inblo_app/util/inblo_desktop_scroll_behavior.dart';

void showCustomDialog({
  required BuildContext context,
  required String title,
  required Widget? Function(BuildContext context) content,
  bool clearHeaders = false,
  double verticalPadding = 12,
  double horizontalPadding = 24,
  double containerPadding = 10,
  void Function()? onClose,
}) {
  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: true,

    // barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 300),
    pageBuilder: (_, __, ___) {
      return LayoutBuilder(
        builder: (ctx, _) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
          child: ScrollConfiguration(
            behavior: InbloDesktopScrollBehavior(),
            child: Center(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                    // height: 1000,
                    margin: EdgeInsets.symmetric(horizontal: 24, vertical: 34),
                    padding: EdgeInsets.all(containerPadding),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Material(
                      type: MaterialType.transparency,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          if (!clearHeaders)
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Spacer(),
                                  Expanded(
                                    flex: 6,
                                    child: Text(
                                      title, // "管理馬の詳細",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: "Roboto",
                                          fontWeight: FontWeight.bold,
                                          color: colorPrimaryDark,
                                          fontSize: 18),
                                    ),
                                  ),
                                  Flexible(
                                      flex: 1,
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        child: Stack(
                                          children: [
                                            SvgPicture.asset(
                                              "assets/svg/ic-close.svg",
                                              height: 35,
                                              width: 35,
                                            ),
                                            Material(
                                              color: Colors.transparent,
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.of(context,
                                                          rootNavigator: true)
                                                      .pop();
                                                },
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: Container(
                                                  width: 35,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: horizontalPadding,
                                vertical: verticalPadding),
                            child: content(context),
                          )
                        ],
                      ),
                    )),
              ),
            ),
          ),
        ),
      );
    },
  ).then((value) {
    onClose?.call();
  });
}

Future<void> showOkDialog(
    BuildContext ctx, String title, String message) async {
  return showDialog<void>(
    context: ctx,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(message),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<bool> showConfirmationDialog(
    BuildContext ctx, String title, String message) async {
  bool? result = await showDialog<bool?>(
    context: ctx,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(message),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              return Navigator.of(context).pop(false);
            },
          ),
          TextButton(
            child: const Text('Confirm'),
            onPressed: () {
              return Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  );
  return result ?? false;
}
