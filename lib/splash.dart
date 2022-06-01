//This screen is used as Splash screen

import 'package:flutter/material.dart';
import 'package:flutterproject/contactUs.dart';
import 'package:flutterproject/dashBoard.dart';
import 'package:flutterproject/login.dart';
import 'package:flutterproject/newLogin.dart';

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 2000), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => dashBored()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: Center(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //  Image(image: AssetImage('assets/movies.jpg'),),
              CircleAvatar(
                radius: 74,
                backgroundImage: AssetImage(
                  'assets/movies.jpg',
                ),
              ),
              Text(
                'Entertainment4U',
                style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
