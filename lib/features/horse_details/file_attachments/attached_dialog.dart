import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:inblo_app/common_widgets/inblo_text_button.dart';
import 'package:inblo_app/features/horse_details/file_attachments/inblo_video_player.dart';
import 'package:inblo_app/constants/app_constants.dart';
import 'package:inblo_app/models/attached_file.dart';
import 'package:mime/mime.dart';
import 'package:video_player/video_player.dart';

class AttachedDialog extends StatefulWidget {
  AttachedDialog({
    required this.dirString,
    required this.attachedFiles,
    super.key,
  });

  AttachedDialog.fromDailyReport(this.attachedFiles)
      : dirString = "/daily-reports-file/";

  AttachedDialog.fromTreatments(this.attachedFiles)
      : dirString = "/treatments-file/";

  String dirString;
  List<AttachedFile> attachedFiles;

  @override
  State<AttachedDialog> createState() => _AttachedDialogState();
}

class _AttachedDialogState extends State<AttachedDialog> {
  int index = 0;
  late VideoPlayerController _videoPlayerController;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
  }

  String getUrlByIndex(int index) {
    return AppConstants.apiUrl +
        widget.dirString +
        widget.attachedFiles[index].filePath!;
  }

  Widget _buildVideoPlayer(AttachedFile attachedFile) {
    return InbloVideoPlayer(
      attachedFile: attachedFile,
      dirString: widget.dirString,
    );
  }

  @override
  Widget build(BuildContext context) {
    var file = widget.attachedFiles[index];
    var fileType = lookupMimeType(file.name!);
    var isImage = fileType?.contains("image") ?? false;
    // print(file.toJson());
    // print(getUrlByIndex(index));
    return Column(
      children: [
        Row(
          children: [
            if (index != 0)
              IconButton(
                onPressed: () {
                  setState(() {
                    index--;
                  });
                },
                icon: Icon(
                  Icons.chevron_left,
                ),
              ),
            Spacer(),
            if ((index + 1) < widget.attachedFiles.length)
              IconButton(
                onPressed: () {
                  setState(() {
                    index++;
                  });
                },
                icon: Icon(
                  Icons.chevron_right,
                ),
              ),
          ],
        ),
        isImage
            ? InteractiveViewer(
                child: file.id == null && !kIsWeb
                    ? Image.file(
                        File(widget.attachedFiles[index].filePath!),
                      )
                    : Image.network(
                        getUrlByIndex(index),
                      ),
              )
            : _buildVideoPlayer(widget.attachedFiles[index]),
      ],
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }
}
