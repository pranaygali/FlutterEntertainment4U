import 'package:flutter/material.dart';
import 'package:flutterproject/moviehomescreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterproject/seatbooking/dateandtime.dart';

class BioMovies extends StatefulWidget {
  const BioMovies({Key? key}) : super(key: key);

  @override
  State<BioMovies> createState() => _BioMoviesState();
}

class _BioMoviesState extends State<BioMovies> {
  String gen = "Biography";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Biography Movies'),
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
                            (snapshot.data! as dynamic).docs[index]['movieUrl'],
                          ),
                        ),
                        /*CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      (snapshot.data! as dynamic).docs[index]
                                          ['movieUrl'],
                                          ),
                                          radius: 4,
                                ),
                                */

                        title: Text(
                          (snapshot.data! as dynamic).docs[index]['moviename'],
                        ),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
