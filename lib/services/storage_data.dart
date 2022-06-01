import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class StorageData {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // adding image to firebase storage
  Future<String> uploadImageToStorage(
      String childName, Uint8List file, bool isPost) async {
    //ref can be a reference to a file that exists or doesn't exists
    //child is the userid to show which user is posting the data
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);

    if (isPost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }

    // to put the data in to the storage
    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snap = await uploadTask;

    // To create a download URL, which we put in the forestore database, such that it can be accessed via network image
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
