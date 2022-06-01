// To display all the movies in the required format

import 'package:flutter/material.dart';
import 'package:flutterproject/admin/moviecloud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MovieCard extends StatefulWidget {
  final snap;
  const MovieCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
            widget.snap['movieUrl'],
            fit: BoxFit.cover,
            height: 150,
            width: 150,
          ),
          Container(
            height: 150,
            width: 220,
            child: Card(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.snap['moviename'],
                      style: TextStyle(fontSize: 20),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        FireStoreMethods().deleteMovie(widget.snap['movieId']);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
