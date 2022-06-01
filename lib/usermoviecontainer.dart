import 'package:flutter/material.dart';
import 'package:flutterproject/admin/moviecloud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterproject/seatbooking/dateandtime.dart';
import 'package:flutterproject/usermovielistscreen.dart';

class UserMovieCard extends StatefulWidget {
  final snap;
  const UserMovieCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<UserMovieCard> createState() => _UserMovieCardState();
}

class _UserMovieCardState extends State<UserMovieCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SelectSchedule()),
          );
        },
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
                    children: [
                      Divider(
                        color: Colors.red,
                      ),
                      Text(
                        'Movie: ' + widget.snap['moviename'],
                        style: TextStyle(fontSize: 20),
                      ),
                      Divider(
                        color: Colors.red,
                      ),
                      Text(
                        'Cast: ' + widget.snap['cast'],
                        style: TextStyle(fontSize: 20),
                      ),
                      Divider(
                        color: Colors.red,
                      ),
                      Text(
                        'Genre: ' + widget.snap['genre'],
                        style: TextStyle(fontSize: 20),
                      ),
                      Divider(
                        color: Colors.red,
                      ),
                      Text(
                        'Director: ' + widget.snap['director'],
                        style: TextStyle(fontSize: 20),
                      ),
                      Divider(
                        color: Colors.red,
                      ),
                      Text(
                        'Producer: ' + widget.snap['producer'],
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
