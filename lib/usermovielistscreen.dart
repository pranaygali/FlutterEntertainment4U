// This file is used to display the movies from the user perspective in the list format

//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/moviegeners/moviecontainer.dart';
import 'package:flutterproject/moviehomescreen.dart';
import 'package:flutterproject/newLogin.dart';
import 'package:flutterproject/services/signupstorage.dart';
import 'package:flutterproject/usermoviecontainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterproject/userprofile.dart';
import 'package:flutterproject/contactUs.dart';
import 'package:flutterproject/searchscreen.dart';

class UserMovieList extends StatefulWidget {
  const UserMovieList({ Key? key }) : super(key: key);

  @override
  State<UserMovieList> createState() => _UserMovieListState();
}

class _UserMovieListState extends State<UserMovieList> {
  String fullname = "";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // it runs during the start of the application, such that we can get the username displayed
  @override
  void initState() {
    super.initState();
    getFullname();
  }

  // creating another function because we cannot make the initstate async
  void getFullname() async {
    // get is a type of future document snapshot
    DocumentSnapshot snap =
        await _firestore.collection('users').doc(_auth.currentUser!.uid).get();

    setState(() {
      // To access the username property from the firebase
      fullname = (snap.data() as Map<String, dynamic>)['fullName'];
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
        backgroundColor: Colors.redAccent[400],
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: Icon(Icons.person),
          );
        } // context function
            ),
            title: Text('Now Showing'),
            centerTitle: true,
      ),
      drawer: Drawer(
        backgroundColor: Colors.redAccent[400],
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
                child: Center(
                    child: Text(
              'Welcome to Entertainment4U',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ))),
            ListTile(
              leading: Icon(Icons.person, color: Colors.white),
              title: Text(
                '$fullname',
                style: TextStyle(color: Colors.white),
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserProfile(
                            uid: FirebaseAuth.instance.currentUser!.uid,
                          )),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.category_outlined,
                color: Colors.white,
              ),
              title: const Text(
                'Geners',
                style: TextStyle(color: Colors.white),
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
              onTap: () {Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => MovieHome()),
  );

                
              },
            ),
            ListTile(
              leading: Icon(
                Icons.favorite_border,
                color: Colors.white,
              ),
              title: const Text(
                'Trending Movies',
                style: TextStyle(color: Colors.white),
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
              onTap: () {
                
              },
            ),
            ListTile(
              leading: Icon(
                Icons.phone,
                color: Colors.white,
              ),
              title: const Text(
                'Contact us',
                style: TextStyle(color: Colors.white),
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => contactus()),
                );
                //  Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              title: const Text(
                'logout',
                style: TextStyle(color: Colors.white),
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
              onTap: () async {
                await AuthMethods().signOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => newLogin(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: 
     
            StreamBuilder(
              //SNapshot is used to fetch the data from the database, immediately in the runtime of the app during.
              //In a nutshell snapshot is used for realtime listening. It displays all the data in the document path
              //Snapshot is a type of AsyncSnapshot
              stream: FirebaseFirestore.instance.collection('movies').snapshots(),
              
              builder: (
                context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
              ) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) =>
                      UserMovieCard(snap: snapshot.data!.docs[index].data()),
                );
              }
              ),
    );
  }
}