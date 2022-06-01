import 'package:flutter/material.dart';
import 'package:flutterproject/moviehomescreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterproject/seatbooking/dateandtime.dart';

class SuperHeroMovies extends StatefulWidget {
  const SuperHeroMovies({Key? key}) : super(key: key);

  @override
  State<SuperHeroMovies> createState() => _SuperHeroMoviesState();
}

class _SuperHeroMoviesState extends State<SuperHeroMovies> {
  String gen = "Superhero";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Superhero Movies'),
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
                    height: 100.0,
                    width: 100.0,
                    child: Card(
                      elevation: 5,
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        leading: Container(
                          height: 300,
                          child: GestureDetector(
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
                              fit: BoxFit.fill,
                              height: 150,
                            ),
                          ),
                        ),
                        title: Text(
                          (snapshot.data! as dynamic).docs[index]['moviename'],
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
