// This file is used to display the profile of the user

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/imageupload.dart';

class UserProfile extends StatefulWidget {
  final uid;
  const UserProfile({Key? key, required this.uid}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  var userData = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    try {
      var snap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();
      userData = snap.data()!;
      setState(() {});
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(userData['photoUrl']),
                  radius: 84,
                ),
                SizedBox(
                  height: 20,
                  child: Divider(
                    color: Colors.red,
                  ),
                ),
                Text(
                  'FullName: ${userData['fullName']}',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                  child: Divider(
                    color: Colors.red,
                  ),
                ),
                Text(
                  'Email: ${userData['email']}',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 30,
                  child: Divider(
                    color: Colors.red,
                  ),
                ),
                Text(
                  'Contact No: ${userData['contactNo']}',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
