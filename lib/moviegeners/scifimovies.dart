//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/moviehomescreen.dart';
import 'package:flutterproject/seatbooking/dateandtime.dart';
import 'package:flutterproject/usermoviecontainer.dart';

class ScifiMovies extends StatefulWidget {
  const ScifiMovies({Key? key}) : super(key: key);

  @override
  State<ScifiMovies> createState() => _ScifiMoviesState();
}

class _ScifiMoviesState extends State<ScifiMovies> {
  String gen = "Sci-fi";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text('Sci-fi Movies List'),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MovieHome()),
              );
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        body: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('movies')
                .where('genre', isEqualTo: gen)
                .get(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                  itemCount: (snapshot.data! as dynamic).docs.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 100,
                      width: 100,
                      child: Card(
                        elevation: 5,
                        margin: EdgeInsets.all(10),
                        child: ListTile(
                          leading: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SelectSchedule(),
                                ),
                              );
                            },
                            child: Image.network(
                              (snapshot.data! as dynamic).docs[index]
                                  ['movieUrl'],
                            ),
                          ),
                          title: Text(
                            (snapshot.data! as dynamic).docs[index]
                                ['moviename'],
                          ),
                        ),
                      ),
                    );
                  });
            }));
  }
}
