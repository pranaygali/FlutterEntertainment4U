import 'package:flutter/material.dart';
import 'package:flutterproject/admin/addmovies.dart';
import 'package:flutterproject/admin/adminmovieslist.dart';
import 'package:flutterproject/admin/removemovies.dart';
import 'package:flutterproject/services/signupstorage.dart';
import 'package:image_picker/image_picker.dart';

imageUpload(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();

  XFile? _file = await _imagePicker.pickImage(source: source);

  if (_file != null) {
    return await _file.readAsBytes();
  }
  print('No image selected');
}

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(content)),
  );
}

//This is used to assign the functionalities of the icons in the bottom navigation bar according to the respective indexes in the adminhome.dart file.
const tabBarItems = [
          AddMovie(),
          
          AdminMovieList(),
          
];
