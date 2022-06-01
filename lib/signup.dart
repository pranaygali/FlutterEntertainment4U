import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutterproject/newLogin.dart';
import 'package:flutterproject/services/signupstorage.dart';
import 'package:image_picker/image_picker.dart';

import 'imageupload.dart';

class singUp extends StatefulWidget {
  const singUp({Key? key}) : super(key: key);

  @override
  State<singUp> createState() => _singUpState();
}

class _singUpState extends State<singUp> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactNoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  void selectImage() async {
    Uint8List im = await imageUpload(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }
  //final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: Icon(Icons.home, color: Colors.red,),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 40,
          ),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            children: [
              Column(
                children: <Widget>[
                  SizedBox(height: 10,),
                  Text(
                    "Sign up",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Create an account",
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      _image != null
                          ? CircleAvatar(
                              radius: 64,
                              backgroundImage: MemoryImage(_image!),
                            )
                          : CircleAvatar(
                              radius: 64,
                              backgroundImage: AssetImage(
                                'assets/avatar.jpeg',
                              ),
                            ),
                      Positioned(
                        bottom: -10,
                        left: 80,
                        child: IconButton(
                            onPressed: selectImage,
                            icon: Icon(
                              Icons.add_a_photo_sharp,
                              color: Colors.red,
                            )),
                      ),
                    ],
                  ),
                  inputFile(
                    label: "Full Name",
                    textEditingController: _fullNameController,
                  ),
                  inputFile(
                    label: "Contact Number",
                    textEditingController: _contactNoController,
                  ),
                  inputFile(
                    label: "Email ID",
                    textEditingController: _emailController,
                  ),
                  inputFile(
                    label: "Password",
                    obscureText: true,
                    textEditingController: _passwordController,
                  ),
                  inputFile(
                    label: "Confirm Password",
                    obscureText: true,
                    textEditingController: _confirmPasswordController,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () async {
                    String res = await AuthMethods().singUpUser(
                        fullName: _fullNameController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                        confirmPassword: _confirmPasswordController.text,
                        contactNo: _contactNoController.text,
                        file: _image!,
                        );
                    print(res);
                     if(res == 'Data sent'){
                      _isLoading = false;
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => newLogin()),
                      );
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Close'),
                            ),
                          ],
                          title: Text('Registration Successfull'),
                          contentPadding: EdgeInsets.all(20),
                          content: Text('User has been registered'),
                        ),
                      );
                    } 
                   else if (res != 'Data sent') {
                      showSnackBar(res, context);
                      
                    } 
                  },
                  color: Colors.red,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(color: Colors.white,),
                          
                        )
                      : Text(
                          "Sign up",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.white),
                        ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Already have an account? '),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => newLogin()),
                      );
                    },
                    child: Text(
                      'Login',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
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
          //  hintText: hintText,
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
