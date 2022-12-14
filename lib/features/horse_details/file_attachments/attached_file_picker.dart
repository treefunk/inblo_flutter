import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inblo_app/models/attached_file.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as path;

class AttachedFilePicker {
  static bool get isMobilePlatform => !kIsWeb;
  static bool get isWebPlatform => kIsWeb;

  static Future pickFile(Function(AttachedFile attachedFile) onPickFile) async {
    if (isMobilePlatform) {
      // Mobile
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
        allowedExtensions: ['png', 'jpg', 'jpeg', 'mp4', 'mov'],
      );

      if (result == null) return;

      File file = File(result.files.single.path!);
      onPickFile(AttachedFile.fromFile(file));
    } else if (isWebPlatform) {
      // Web
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false, // file filtering is limited in web
      );

      if (result == null) return;
      Uint8List? uploadfile = result.files.single.bytes;

      if (uploadfile != null) {
        String filename = path.basename(result.files.single.name);

        bool isValidFileFormat = lookupMimeType(filename)!.contains("image") ||
            lookupMimeType(filename)!.contains("video");

        if (!isValidFileFormat) {
          throw (Exception("Please select a valid image or video file type."));
        }

        AttachedFile attachedFile =
            AttachedFile.fromU8intList(filename, uploadfile);
        onPickFile(attachedFile);
      }
    } else {
      // platform is not supported
    }
  }

  static Future captureImage(
      Function(AttachedFile attachedFile) onCaptureImage) async {
    if (isMobilePlatform) {
      XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;

      AttachedFile attachedFile = AttachedFile.fromXFile(image);
      onCaptureImage(attachedFile);
    } else if (isWebPlatform) {
      // not supported
    } else {
      // not supported
    }
  }
}
