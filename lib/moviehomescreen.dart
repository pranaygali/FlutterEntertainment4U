import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/contactUs.dart';
import 'package:flutterproject/detailsPage.dart';
import 'package:flutterproject/imageupload.dart';
import 'package:flutterproject/moviegeners/actionmovies.dart';
import 'package:flutterproject/moviegeners/biographymovies.dart';
import 'package:flutterproject/moviegeners/comedymovies.dart';
import 'package:flutterproject/moviegeners/dramamovies.dart';
import 'package:flutterproject/moviegeners/horrormovies.dart';
import 'package:flutterproject/moviegeners/romancemovies.dart';
import 'package:flutterproject/moviegeners/scifimovies.dart';
import 'package:flutterproject/moviegeners/superheromovies.dart';
import 'package:flutterproject/newLogin.dart';
import 'package:flutterproject/searchscreen.dart';
import 'package:flutterproject/services/signupstorage.dart';
import 'package:flutterproject/trendingmovies.dart/alltrendingmovies.dart';
import 'package:flutterproject/usermoviecontainer.dart';
import 'package:flutterproject/usermovielistscreen.dart';
import 'package:flutterproject/userprofile.dart';
import 'package:flutterproject/admin/moviecloud.dart';

class MovieHome extends StatefulWidget {
  const MovieHome({Key? key}) : super(key: key);

  @override
  State<MovieHome> createState() => _MovieHomeState();
}

class _MovieHomeState extends State<MovieHome> {
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
    return Scaffold(
      appBar: AppBar(
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
                Icons.favorite_border,
                color: Colors.white,
              ),
              title: const Text(
                'Trending Movies',
                style: TextStyle(color: Colors.white),
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TrendMovies()),
                );
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.search_rounded,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SearchScreen()),
                      );
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserMovieList()),
                      );
                    },
                    child: Text('List all the movies'),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  child: Column(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ActionMovies()),
                            );
                          },
                          child: Image.asset(
                            'assets/Aachaarya.jpeg',
                            width: 200,
                            height: 200,
                          )),
                      Text(
                        'Action',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BioMovies()),
                            );
                          },
                          child: Image.asset(
                            'assets/major.jpeg',
                            width: 180,
                            height: 200,
                          )),
                      Text(
                        'Biography',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ],
            ), // First row
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Container(
                  child: Column(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ComedyMovies()),
                            );
                          },
                          child: Image.asset(
                            'assets/f2.jpeg',
                            width: 200,
                            height: 200,
                          )),
                      Text(
                        'Comedy',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DramaMovies()),
                            );
                          },
                          child: Image.asset(
                            'assets/avpl.jpeg',
                            width: 180,
                            height: 200,
                          )),
                      Text(
                        'Drama',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ],
            ), // second row
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Container(
                  child: Column(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HorrorMovies()),
                            );
                          },
                          child: Image.asset(
                            'assets/rebel.jpeg',
                            width: 200,
                            height: 200,
                          )),
                      Text(
                        'Horror',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RomanceMovies()),
                            );
                          },
                          child: Image.asset(
                            'assets/RadheyShyam.jpeg',
                            width: 180,
                            height: 200,
                          )),
                      Text(
                        'Romance',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ],
            ), //third row
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Container(
                  child: Column(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ScifiMovies()),
                            );
                          },
                          child: Image.asset(
                            'assets/ismart.jpeg',
                            width: 200,
                            height: 200,
                          )),
                      Text(
                        'Sci-fi',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SuperHeroMovies()),
                            );
                          },
                          child: Image.asset(
                            'assets/TheBatman.jpeg',
                            width: 180,
                            height: 200,
                          )),
                      Text(
                        'Superhero',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
