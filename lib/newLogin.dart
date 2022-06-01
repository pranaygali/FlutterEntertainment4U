//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutterproject/admin/adminhome.dart';
import 'package:flutterproject/homeScreen.dart';
import 'package:flutterproject/moviehomescreen.dart';
import 'package:flutterproject/services/auth.dart';
import 'package:flutterproject/services/signupstorage.dart';
import 'package:flutterproject/imageupload.dart';
import 'package:flutterproject/signup.dart';
import 'package:flutterproject/provider/userprovider.dart';
import 'package:provider/provider.dart';
//import 'package:flutterproject/loginCreate.dart';

// void main() => runApp(app)

class newLogin extends StatefulWidget {
  const newLogin({Key? key}) : super(key: key);

  @override
  State<newLogin> createState() => _newLoginState();
}

class _newLoginState extends State<newLogin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isloading = false;

  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  void leginUser() async {
    setState(() {
      _isloading = true;
    });
    String res = await AuthMethods().leginUser(
        email: _emailController.text, password: _passwordController.text);

    if (res == "success" && _emailController.text == "admin@gmail.com" &&
        _passwordController.text == "nimda@123") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => adminHome()),
      );
    } else if (res == "success") {
      print(_emailController);
      print(_passwordController);
      showSnackBar(res, context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MovieHome()),
      );
    } else {
      showSnackBar(res, context);
    }
    setState(() {
      _isloading = false;
    });
  }

// The login is working

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  resizeToAvoidBottomInset: false,
      // backgroundColor: Colors.red,
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: Icon(Icons.home, color: Colors.red,),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        "Entertainment4U",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Login to your account",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: <Widget>[
                        inputFile(
                            label: "Email",
                            textEditingController: _emailController),
                        inputFile(
                            label: "Password",
                            obscureText: true,
                            textEditingController: _passwordController),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: leginUser,
                      color: Colors.red,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: _isloading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              "Login",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Don't have an account?"),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => singUp()),
                          );
                        },
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget inputFile(
    {label, obscureText = false, hintText, textEditingController}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
      SizedBox(
        height: 5,
      ),
      TextField(
        controller: textEditingController,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        ),
      ),
      SizedBox(height: 10),
    ],
  );
}
