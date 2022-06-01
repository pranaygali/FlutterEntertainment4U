// For the anonymous sign in, we don't use this 

import 'package:flutter/material.dart';
import 'package:flutterproject/services/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _auth = AuthService(); // accessing the class from auth.dart
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: FlatButton.icon(
          onPressed: () async {
            //Navigator.pushNamed(context, '/home');
            dynamic loginConfirm = await _auth.siginInAnon();
            if (loginConfirm == null) {
              print('Error signing in');
            } else {
              print('signed in');
              print(loginConfirm);
            }
          },
          icon: Icon(Icons.forward),
          label: Text(''),
        ),
      ),
    );
  }
}
