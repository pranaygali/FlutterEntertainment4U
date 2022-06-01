//This file has methods defined to add and delete a movie to the database

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterproject/services/storage_data.dart';
import 'package:flutterproject/userDetails/movie.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterproject/userDetails/user.dart' as model;

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uploadMovie(
      String moviename,
      String synopsis,
      String cast,
      String genre,
      String director,
      String producer,
      Uint8List file,
      String uid,
      String fullname,
      String profImage) async {
    String res = "Enter all the details";
    try {
      String photoUrl =
          await StorageData().uploadImageToStorage('movies', file, true);

      String movieId = const Uuid().v1();

      Movie movie = Movie(
          moviename: moviename,
          synopsis: synopsis,
          cast: cast,
          genre: genre,
          director: director,
          producer: producer,
          profImage: profImage,
          movieUrl: photoUrl,
          uid: uid,
          movieId: movieId,
          fullname: fullname);

      _firestore.collection('movies').doc(movieId).set(
            movie.toJson(),
          );

      res = "Data Sent";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //Delete a movie

  Future<String> deleteMovie(String movieId) async {
    String res = "Some error occurred";
    try {
      await _firestore.collection('movies').doc(movieId).delete();
      res = 'success';
      if (res == 'success') {
        print('deleted!');
      } else {
        print('not deleted');
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
