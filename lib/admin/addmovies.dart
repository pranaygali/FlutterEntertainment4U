import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutterproject/admin/moviecloud.dart';
import 'package:flutterproject/imageupload.dart';
import 'package:flutterproject/newLogin.dart';
import 'package:flutterproject/provider/userprovider.dart';
import 'package:flutterproject/userDetails/user.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutterproject/userDetails/movie.dart';
import 'package:provider/provider.dart';
import 'package:flutterproject/newLogin.dart';
import 'package:flutterproject/services/signupstorage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddMovie extends StatefulWidget {
  const AddMovie({Key? key}) : super(key: key);

  @override
  State<AddMovie> createState() => _AddMovieState();
}

class _AddMovieState extends State<AddMovie> {
  Uint8List? _file;
  final TextEditingController movieNameController = TextEditingController();
  final TextEditingController synopsisController = TextEditingController();
  final TextEditingController castController = TextEditingController();
  final TextEditingController genreController = TextEditingController();
  final TextEditingController directorNameController = TextEditingController();
  final TextEditingController producerController = TextEditingController();
  bool _isLoading = false;
  String uid = "";
  String fullname = "";
  String profImage = "";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    getdetails();
  }

// to get the userdetails from the cloud
  void getdetails() async {
    // get is a type of future document snapshot
    DocumentSnapshot snap =
        await _firestore.collection('users').doc(_auth.currentUser!.uid).get();

    setState(() {
      // To access the username property from the firebase
      fullname = (snap.data() as Map<String, dynamic>)['fullName'];
      uid = (snap.data() as Map<String, dynamic>)['uid'];
      profImage = (snap.data() as Map<String, dynamic>)['photoUrl'];
    });
  }

  void postMovie(
    String uid,
    String fullname,
    String profImage,
  ) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await FireStoreMethods().uploadMovie(
          movieNameController.text,
          synopsisController.text,
          castController.text,
          genreController.text,
          directorNameController.text,
          producerController.text,
          _file!,
          uid,
          fullname,
          profImage);
      print("after uploading res = " + res);
      if (res == "Data Sent") {
        setState(() {
          _isLoading = false;
        });
        showSnackBar('Posted!', context);
        fieldsClear();
        clearMovie();
      } else {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(res, context);
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

// to select the image to upload
  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text('Add movie image'),
            children: [
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: Text('Take a photo'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await imageUpload(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: Text('Choose from gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await imageUpload(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: Text('cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

/*
  @override
  void dispose() {
    super.dispose();
    movieNameController.dispose();
    synopsisController.dispose();
    castController.dispose();
    directorNameController.dispose();
    producerController.dispose();
  }

  */

// we used this function to go back to uploading another movie after posting a movie to the db
  void clearMovie() {
    setState(() {
      _file = null;
    });
  }

  void fieldsClear() {
    movieNameController.clear();
    synopsisController.clear();
    castController.clear();
    directorNameController.clear();
    producerController.clear();
    genreController.clear();
  }

  @override
  Widget build(BuildContext context) {
    // To access the user details in this page from the cloud.
    // final User user = Provider.of<UserProvider>(context).getUser;

    return _file == null
        ? Scaffold(
            appBar: AppBar(
              title: Text('Welcome Admin'),
              backgroundColor: Colors.red,
              leading: IconButton(
                icon: Icon(Icons.logout),
                onPressed: () async {
                  await AuthMethods().signOut();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => newLogin(),
                    ),
                  );
                },
              ),
            ),
            body: Center(
              child: IconButton(
                icon: Icon(Icons.upload_file),
                onPressed: () => _selectImage(context),
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.red,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: clearMovie,
              ),
              title: Text('Add a movie'),
              actions: [
                TextButton(
                  onPressed: () => postMovie(uid, fullname, profImage),

                  /*
                  async {
                    setState(() {
                      _isLoading = true;
                    });
                    String res = await FireStoreMethods().uploadMovie(
                        movieNameController.text,
                        synopsisController.text,
                        castController.text,
                        directorNameController.text,
                        producerController.text,
                        _file!);
                    print(res);
                    if (res == "success") {
                      setState(() {
                        _isLoading = false;
                      });
                      showSnackBar('Movie added', context);
                      fieldsClear();
                      clearMovie();
                    } else {
                      setState(() {
                        _isLoading = false;
                      });
                      showSnackBar(res, context);
                    }
                  },
                  */
                  child: Text(
                    'Add',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 35),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _isLoading
                        ? Padding(
                            padding: EdgeInsets.only(right: 30),
                            child: const LinearProgressIndicator())
                        : const Padding(
                            padding: EdgeInsets.only(top: 0, right: 30)),
                    const Divider(),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 95),
                      child: CircleAvatar(
                        backgroundImage: MemoryImage(_file!),
                        radius: 84,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextField(
                        controller: movieNameController,
                        decoration: InputDecoration(
                          hintText: 'Enter movie name',
                          border: OutlineInputBorder(),
                          labelText: 'ENTER MOVIE NAME',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextField(
                        controller: synopsisController,
                        decoration: InputDecoration(
                          hintText: 'Enter Synopsis',
                          border: OutlineInputBorder(),
                          labelText: 'ENTER MOVIE SYNOPSIS',
                          //contentPadding: const EdgeInsets.all(8)
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextField(
                        controller: castController,
                        decoration: InputDecoration(
                          hintText: 'Enter Cast details',
                          border: OutlineInputBorder(),
                          labelText: 'ENTER MOVIE CAST',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextField(
                        controller: genreController,
                        decoration: InputDecoration(
                          hintText: 'Enter Genre ',
                          border: OutlineInputBorder(),
                          labelText: 'ENTER MOVIE GENRE',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextField(
                        controller: directorNameController,
                        decoration: InputDecoration(
                          hintText: 'Enter Director',
                          border: OutlineInputBorder(),
                          labelText: 'ENTER MOVIE DIRECTOR NAME',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextField(
                        controller: producerController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'ENTER MOVIE PRODUCER NAME',
                          hintText: 'Enter producer',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
