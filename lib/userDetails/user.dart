import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String fullName;
  final String email;
  final String password;
  final String confirmPassword;
  final String contactNo;
  final List favourites;
  final List geners;
  final String uid;
  final String photoUrl;

  User(
      {required this.fullName,
      required this.email,
      required this.password,
      required this.confirmPassword,
      required this.contactNo,
      required this.favourites,
      required this.geners,
      required this.uid,
      required this.photoUrl});

  // This method is used to convert user object from the above class we require to an object, such that we can re-use it any where
  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "email": email,
        "password": password,
        "confirmPassword": confirmPassword,
        "contactNo": contactNo,
        "favourites": favourites,
        "geners": geners,
        "uid": uid,
        "photoUrl": photoUrl,
      };

  // This function takes snapshot and returns user model
  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
        fullName: snapshot['fullName'],
        email: snapshot['email'],
        password: snapshot['password'],
        confirmPassword: snapshot['confrimPassword'],
        contactNo: snapshot['contactNo'],
        favourites: snapshot['favourites'],
        geners: snapshot['geners'],
        uid: snapshot['uid'],
        photoUrl: snapshot['photoUrl']);
  }
}
