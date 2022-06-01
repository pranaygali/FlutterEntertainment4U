import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/moviehomescreen.dart';
import 'package:http/http.dart' as http;

class PaymentDone extends StatefulWidget {
  const PaymentDone({Key? key}) : super(key: key);

  @override
  State<PaymentDone> createState() => _PaymentDoneState();
}

class _PaymentDoneState extends State<PaymentDone> {
  TextEditingController sendMailController = TextEditingController();
  String mailSubject = "Booking confirmation";

  String userEmail = "";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // it runs during the start of the application, such that we can get the username displayed
  @override
  void initState() {
    super.initState();
    getFullname();
  }

  // creating another function because we cannot make the initstate async
  void getFullname() async {
    // get is a type of future document snapshot
    DocumentSnapshot snap =
        await _firestore.collection('users').doc(_auth.currentUser!.uid).get();

    setState(() {
      // To access the username property from the firebase
      userEmail = (snap.data() as Map<String, dynamic>)['email'];
    });
  }

  Future sendEmail() async {
    final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
    const serviceId = "service_0kj0rsc";
    const templateId = "template_94e950x";
    const userId = "ACqU9jUJKrVvMggHs";
    const accessToken = "l-Gy7Jiy8xi9ZB-cgJ2pU";

    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "service_id": serviceId,
          "template_id": templateId,
          "user_id": userId,
          "accessToken": accessToken,
          "template_params": {
            "subject": "Booking Confirmation",
            "message": "Thank you for your purchase today, enjoy your movie!",
            "user_email": userEmail,
          }
        }));
    print(
        "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!??????????????????????????????????!!!!!!!!!!!!!!!!!!!!!");
    print("The response is " + response.body.toString());
    return response.statusCode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text('Booking Confirmation'),
        leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MovieHome()),
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Yay! Your booking has been confirmed!',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 30,
              child: Divider(
                color: Colors.red,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Confirmation mail has been sent to: ',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                userEmail,
                style: TextStyle(fontSize: 20),
              ),
            ),

            /*
            SizedBox(
              height: 20,
              child: Divider(
                color: Colors.red,
              ),
            ),
            


            
            Text(
              'Enter your email below to send the tickets',
              style: TextStyle(fontSize: 20),
            ),
            
            
            Padding(
              padding: EdgeInsets.all(30),
              child: TextField(
                controller: sendMailController,
                decoration: InputDecoration(
                  hintText: 'Confirm your mail id',
                  border: OutlineInputBorder(),
                  labelText: 'confirm your mail id',
                ),
              ),
            ),
            MaterialButton(
              onPressed: () {
                sendEmail();
              },
              child: Text(
                'Send confirmation',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.red,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              height: 60,
            ),
            */
          ],
        ),
      ),
    );
  }
}
