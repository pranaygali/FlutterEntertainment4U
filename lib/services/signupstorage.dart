// This file is used to store the signup details of a new user in to the firebase
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterproject/services/storage_data.dart';
import 'package:flutterproject/signup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterproject/userDetails/user.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // To access all the user details
  Future<model.User> getUserDetails() async {
    User currentUser = _auth
        .currentUser!; // the _auth.currentUser is given by the firebase, it is no defined while programming.

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();

    /*This function doesn't accept snapshot as return type, instead of returning each and every element in the variable seperatley, 
     we created a function
     */
    return model.User.fromSnap(snap);
  }

  Future<String> singUpUser({
    required String fullName,
    required String email,
    required String password,
    required String confirmPassword,
    required String contactNo,
    required Uint8List file,
  }) async {
    String res = "An error occured";
    try {
      if (fullName.isNotEmpty ||
          email.isNotEmpty ||
          password.isNotEmpty ||
          confirmPassword.isNotEmpty ||
          contactNo.isNotEmpty) {
        UserCredential userdetails = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(userdetails.user!.uid);

        String photoUrl = await StorageData()
            .uploadImageToStorage('profilePics', file, false);

        model.User user = model.User(
          fullName: fullName,
          uid: userdetails.user!.uid,
          email: email,
          password: password,
          confirmPassword: confirmPassword,
          contactNo: contactNo,
          favourites: [],
          geners: [],
          photoUrl: photoUrl,
        );

        // The users is the collection data folder in the firebase.

        await _firestore
            .collection('users')
            .doc(userdetails.user!.uid)
            .set(user.toJson());
        /*  await _firestore.collection('users').doc(userdetails.user!.uid).set({
          'fullname': fullName,
          'uid': userdetails.user!.uid,
          'email': email,
          'password': password,
          'confirmPassword': confirmPassword,
          'contactno': contactNo,
          'favourites': [],
          'genres': [],
          'photoUrl': photoUrl,
        });
        */

        /*  await _firestore.collection('users').add({
          'fullname': fullName,
          'uid': userdetails.user!.uid,
          'email': email,
          'password': password,
          'confirmPassword': confirmPassword,
          'contactno': contactNo,
        }); */
        res = "Data sent";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

// login user
  Future<String> leginUser(
      {required String email, required String password}) async {
    String res = "Some error occured";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);

        res = "success";
      } else {
        res = "Please enter all the required fields";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // signout user
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
