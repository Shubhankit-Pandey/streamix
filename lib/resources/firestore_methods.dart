import 'dart:ffi';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streamix/models/livestream.dart';
import 'package:streamix/providers/user_provider.dart';
import 'package:streamix/resources/storage_methods.dart';
import 'package:streamix/utils/utils.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StorageMethods _storageMethods = StorageMethods();
  startLiveStream(BuildContext context, String title, Uint8List? image) async {
    final user = Provider.of<UserProvider>(context, listen: false);
    try {
      if (title.isNotEmpty) {
        if ((await _firestore.collection('livestream').doc(user.user.uid).get())
            .exists) {
          String thumbnailUrl = await _storageMethods.uploadImagetoStorage(
            "livestream-thumbnails",
            image!,
            user.user.uid,
          );
          String channelId = '${user.user.uid}${user.user.username}';
          LiveStream liveStream = LiveStream(
            title: title,
            image: thumbnailUrl,
            uid: user.user.uid,
            username: user.user.username,
            startedAt: DateTime.now(),
            viewers: 0,
            channelId: channelId,
          );
          _firestore
              .collection('livestream')
              .doc(channelId)
              .set(liveStream.toMap());
        }
      } else {
        showSnackBar(context, "Please enter all fields.");
      }
    } on FirebaseException catch (e) {
      showSnackBar(context, e.message!);
    }
  }
}
