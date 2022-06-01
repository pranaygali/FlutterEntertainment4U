import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/seatbooking/dateandtime.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isShowMovies = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: TextFormField(
              controller: searchController,
              decoration: InputDecoration(labelText: 'browse movies'),
              onFieldSubmitted: (String typist) {
                print(typist);
                print(searchController.text);
                setState(() {
                  isShowMovies = true;
                });
              }),
        ),
        body: isShowMovies
            ? FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('movies')
                    .where('moviename',
                        isGreaterThanOrEqualTo: searchController.text)
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
                        return ListTile(
                          leading: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SelectSchedule(),
                                ),
                              );
                            },
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  (snapshot.data! as dynamic).docs[index]
                                      ['movieUrl']),
                            ),
                          ),
                          title: Text(
                            (snapshot.data! as dynamic).docs[index]
                                ['moviename'],
                          ),
                        );
                      });
                })
            : Center(
                child: Text(
                  'Movies',
                  style: TextStyle(fontSize: 30),
                ),
              ));
  }
}
