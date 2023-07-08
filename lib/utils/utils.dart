import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

Future<Uint8List?> pickImage() async {
  PermissionStatus status = await Permission.photos.status;
  // if (status.isRestricted) print("restrictd");
  if (status == PermissionStatus.granted) {
    FilePickerResult? pickedImage =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (pickedImage != null) {
      if (kIsWeb) {
        return pickedImage.files.single.bytes;
      }
      return await File(pickedImage.files.single.path!).readAsBytes();
    }
  }
  return null;
}
