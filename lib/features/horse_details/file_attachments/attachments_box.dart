import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:inblo_app/features/horse_details/file_attachments/attached_dialog.dart';
import 'package:inblo_app/common_widgets/inblo_text_button.dart';
import 'package:inblo_app/constants/app_theme.dart';
import 'package:inblo_app/constants/text_styles.dart';
import 'package:inblo_app/models/attached_file.dart';

import '../../../common_widgets/general_dialog.dart';

class AttachmentsBox extends StatefulWidget {
  AttachmentsBox({
    super.key,
    required this.attachedFiles,
    required this.onCaptureImage,
    required this.onPickFile,
    required this.onDeleteExisting,
    required this.onDeleteUploaded,
  });

  List<AttachedFile> attachedFiles;

  Function() onCaptureImage;
  Function() onPickFile;
  Function(int index) onDeleteExisting;
  Function(int index) onDeleteUploaded;

  @override
  State<AttachmentsBox> createState() => _AttachmentsBoxState();
}

class _AttachmentsBoxState extends State<AttachmentsBox> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                "添付ファイル:", // "管理馬の詳細",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: "Hiragino",
                  fontWeight: FontWeight.bold,
                  color: colorPrimary,
                  fontSize: 13,
                ),
              ),
            ),

            // Spacer(),
            Flexible(
              child: InbloTextButton(
                onPressed: () async {
                  // captureImage();
                  // widget.onPressUpload();
                  int choice = await _showSimpleDialog(context) as int;
                  if (choice == 0) {
                    widget.onCaptureImage();
                  } else if (choice == 1) {
                    widget.onPickFile();
                  } else {
                    //
                  }
                },
                title: "ファイルを追加",
                iconPrefix: Icon(
                  Icons.attach_file,
                  color: Colors.white,
                  size: 20,
                ),
                textStyle: TextStyleInbloButton.small,
              ),
            ),
            // Spacer()
          ],
        ),
        if (widget.attachedFiles.isNotEmpty)
          Container(
            margin: EdgeInsets.only(top: 8),
            child: Divider(
              color: colorPrimaryDark,
            ),
          ),
        if (widget.attachedFiles.isNotEmpty)
          for (var i = 0; i < widget.attachedFiles.length; i++)
            Container(
              margin: EdgeInsets.only(bottom: 6),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          showCustomDialog(
                            context: context,
                            title: "",
                            content: (ctx) => AttachedDialog.fromDailyReport(
                                [widget.attachedFiles[i]]),
                          );
                        },
                        child: Row(children: [
                          Icon(
                            Icons.image_outlined,
                            color: widget.attachedFiles[i].id == null
                                ? colorPrimaryDark
                                : colorPrimary,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Expanded(
                            child: Text(
                              widget.attachedFiles[i].name!,
                              overflow: TextOverflow.ellipsis,
                              style: attachedTxtStyle,
                              maxLines: 1,
                              softWrap: false,
                            ),
                          ),
                        ]),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                          splashColor: colorPrimary,
                          highlightColor: colorDarkBackground,
                          onTap: () {
                            if (widget.attachedFiles[i].id == null) {
                              var uploadedIndex =
                                  (widget.attachedFiles.isNotEmpty
                                          ? widget.attachedFiles.length
                                          : 0) -
                                      i -
                                      1;
                              print(
                                  "attempting to remove index $uploadedIndex \n index: $i");
                              // setState(() {
                              //   _uploadedFiles.removeAt(uploadedIndex);
                              // });
                              widget.onDeleteUploaded(
                                  uploadedIndex); // delete local files to be uploaded
                            } else {
                              // setState(() {
                              //   attachedFiles.removeAt(i);
                              // });
                              widget.onDeleteExisting(
                                  i); // delete existing uploades on the server
                            }
                          },
                          child: Icon(
                            Icons.delete_forever,
                            color: Colors.red[800],
                          )),
                    ),
                  ],
                ),
              ),
            ),
      ],
    );
  }
}

Future<int?> _showSimpleDialog(BuildContext context) async {
  return await showDialog<int?>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          // <-- SEE HERE
          title: const Text('Select Upload'),
          children: <Widget>[
            if (!kIsWeb)
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop(0);
                },
                child: const Text('Camera'),
              ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop(1);
              },
              child: const Text('Pick file from gallery'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop(-1);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      });
}
