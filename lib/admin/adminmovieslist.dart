//This file is used to display the movies added in the the databse from admin perpective

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/moviegeners/moviecontainer.dart';
import 'package:flutterproject/moviehomescreen.dart';
import 'package:flutterproject/newLogin.dart';
import 'package:flutterproject/services/signupstorage.dart';

class AdminMovieList extends StatefulWidget {
  const AdminMovieList({Key? key}) : super(key: key);

  @override
  State<AdminMovieList> createState() => _AdminMovieListState();
}

class _AdminMovieListState extends State<AdminMovieList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('All Movies'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () async {
            await AuthMethods().signOut();
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => newLogin(),
              ),
            );
          },
          icon: Icon(
            Icons.logout,
          ),
        ),
      ),
      body: StreamBuilder(
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
                  MovieCard(snap: snapshot.data!.docs[index].data()),
            );
          }),
    );
  }
}
