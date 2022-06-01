import 'package:flutter/material.dart';
import 'package:flutterproject/newLogin.dart';
import 'package:flutterproject/services/signupstorage.dart';


class RemoveMovie extends StatefulWidget {
  const RemoveMovie({ Key? key }) : super(key: key);

  @override
  State<RemoveMovie> createState() => _RemoveMovieState();
}

class _RemoveMovieState extends State<RemoveMovie> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: IconButton(icon: Icon(Icons.logout), onPressed: () async {
            await AuthMethods().signOut();
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => newLogin(),
              ),
            );
          },)
      ),
      
    );
  }
}


/*
class RemoveMovie extends StatefulWidget {
  const RemoveMovie({ Key? key }) : super(key: key);

  @override
  State<RemoveMovie> createState() => _RemoveMovieState();
}

class _RemoveMovieState extends State<RemoveMovie> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: IconButton(icon: Icon(Icons.logout), onPressed: () async {
            await AuthMethods().signOut();
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => newLogin(),
              ),
            );
          },)
      ),
      
    );
  }
}

*/