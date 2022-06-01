import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/payment/paymentgateway.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutterproject/seatbooking/dateandtime.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SeatLayout extends StatefulWidget {
  const SeatLayout({Key? key}) : super(key: key);

  @override
  State<SeatLayout> createState() => _SeatLayoutState();
}

class _SeatLayoutState extends State<SeatLayout> {
  int gonext = 0;
  int dating = 0;
  bool seatColor1 = true;
  bool seatColor2 = true;
  bool seatColor3 = true;
  bool seatColor4 = true;
  bool seatColor5 = true;
  bool seatColor6 = true;
  bool seatColor7 = true;
  bool seatColor8 = true;
  bool seatColor9 = true;
  bool seatColor10 = true;
  bool seatColor11 = true;
  bool seatColor12 = true;
  bool seatColor13 = true;
  bool seatColor14 = true;
  bool seatColor15 = true;
  bool seatColor16 = true;
  bool seatColor17 = true;
  bool seatColor18 = true;
  bool seatColor19 = true;
  bool seatColor20 = true;
  bool seatColor21 = true;
  bool seatColor22 = true;
  bool seatColor23 = true;
  bool seatColor24 = true;
  bool seatColor25 = true;

  late Razorpay razorpay;

  int finalAmount = 150;

  TextEditingController sendMailController = TextEditingController();
  String mailSubject = "Booking confirmation";

  String userEmail = "";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();

    razorpay = new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    razorpay.clear();
  }

  void getFullname() async {
    // get is a type of future document snapshot
    DocumentSnapshot snap =
        await _firestore.collection('users').doc(_auth.currentUser!.uid).get();

    setState(() {
      // To access the username property from the firebase
      userEmail = (snap.data() as Map<String, dynamic>)['email'];
    });
  }

  // Function to send the email confirmation
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

  //Function that initiates the API
  void openCheckout() async {
    int amountPurcahsed = int.parse(finalAmount.toString());
    var options = {
      "key": "rzp_test_SFxEqBDo1xFlnr",
      "amount": 100 * 100,
      "name": "Entertainment4U",
      "description": "Movie ticket purchase",
      "prefill": {
        "contact": "9848022338",
        "email": "pranay.gali@gmail.com",
      },
      "external": {
        "wallets": ["paytm"]
      }
    };
    try {
      razorpay.open(options);
      sendEmail();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PaymentDone()),
      );
    } catch (e) {
      print("Error is" + e.toString());
    }
  }

  void handlerPaymentSuccess() {
    print("payment Success");
  }

  void handlerErrorFailure() {
    print("payment Failed");
  }

  void handlerExternalWallet() {
    print("External Wallet");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Select Seats'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40),
            Text(
              'SELECT NO.OF SEATS',
              style: TextStyle(color: Colors.white),
            ),
            Container(
              width: 100,
              color: Colors.white,
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.remove,
                      color: Colors.black,
                    ),
                    SizedBox(
                        height: 30,
                        child: Text(
                          '${dating}',
                          style: TextStyle(fontSize: 20),
                        )),
                    Icon(
                      Icons.add,
                      color: Colors.black,
                    )
                  ]),
            ),
            SizedBox(height: 30),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'E',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        seatColor1 = !seatColor1;
                      });
                    },
                    icon: Icon(Icons.chair,
                        color: seatColor1 ? Colors.white : Colors.red)),
                IconButton(
                    onPressed: () {
                      setState(() {
                        seatColor2 = !seatColor2;
                      });
                    },
                    icon: Icon(Icons.chair,
                        color: seatColor2 ? Colors.white : Colors.red)),
                IconButton(
                    onPressed: () {
                      setState(() {
                        seatColor3 = !seatColor3;
                      });
                    },
                    icon: Icon(Icons.chair,
                        color: seatColor3 ? Colors.white : Colors.red)),
                IconButton(
                    onPressed: () {
                      setState(() {
                        seatColor4 = !seatColor4;
                      });
                    },
                    icon: Icon(Icons.chair,
                        color: seatColor4 ? Colors.white : Colors.red)),
                IconButton(
                    onPressed: () {
                      setState(() {
                        seatColor5 = !seatColor5;
                      });
                    },
                    icon: Icon(Icons.chair,
                        color: seatColor5 ? Colors.white : Colors.red)),
                Text(
                  'E',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                )
              ],
            ),
            SizedBox(height: 30),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'D',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        seatColor6 = !seatColor6;
                      });
                    },
                    icon: Icon(Icons.chair,
                        color: seatColor6 ? Colors.white : Colors.red)),
                IconButton(
                    onPressed: () {
                      setState(() {
                        seatColor7 = !seatColor7;
                      });
                    },
                    icon: Icon(Icons.chair,
                        color: seatColor7 ? Colors.white : Colors.red)),
                IconButton(
                    onPressed: () {
                      setState(() {
                        seatColor8 = !seatColor8;
                      });
                    },
                    icon: Icon(Icons.chair,
                        color: seatColor8 ? Colors.white : Colors.red)),
                IconButton(
                    onPressed: () {
                      setState(() {
                        seatColor9 = !seatColor9;
                      });
                    },
                    icon: Icon(Icons.chair,
                        color: seatColor9 ? Colors.white : Colors.red)),
                IconButton(
                    onPressed: () {
                      setState(() {
                        seatColor10 = !seatColor10;
                      });
                    },
                    icon: Icon(Icons.chair,
                        color: seatColor10 ? Colors.white : Colors.red)),
                Text(
                  'D',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                )
              ],
            ),
            SizedBox(height: 30),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'C',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        seatColor11 = !seatColor11;
                      });
                    },
                    icon: Icon(Icons.chair,
                        color: seatColor11 ? Colors.white : Colors.red)),
                IconButton(
                    onPressed: () {
                      setState(() {
                        seatColor12 = !seatColor12;
                      });
                    },
                    icon: Icon(Icons.chair,
                        color: seatColor12 ? Colors.white : Colors.red)),
                IconButton(
                    onPressed: () {
                      setState(() {
                        seatColor13 = !seatColor13;
                      });
                    },
                    icon: Icon(Icons.chair,
                        color: seatColor13 ? Colors.white : Colors.red)),
                IconButton(
                    onPressed: () {
                      setState(() {
                        seatColor14 = !seatColor14;
                      });
                    },
                    icon: Icon(Icons.chair,
                        color: seatColor14 ? Colors.white : Colors.red)),
                IconButton(
                    onPressed: () {
                      setState(() {
                        seatColor15 = !seatColor15;
                        print(seatColor15);
                      });
                    },
                    icon: Icon(Icons.chair,
                        color: seatColor15 ? Colors.white : Colors.red)),
                Text(
                  'C',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                )
              ],
            ),
            SizedBox(height: 30),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'B',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        seatColor16 = !seatColor16;
                        print(seatColor16);
                      });
                    },
                    icon: Icon(Icons.chair,
                        color: seatColor16 ? Colors.white : Colors.red)),
                IconButton(
                    onPressed: () {
                      setState(() {
                        seatColor17 = !seatColor17;
                        print(seatColor15);
                      });
                    },
                    icon: Icon(Icons.chair,
                        color: seatColor17 ? Colors.white : Colors.red)),
                IconButton(
                    onPressed: () {
                      setState(() {
                        seatColor18 = !seatColor18;
                        print(seatColor15);
                      });
                    },
                    icon: Icon(Icons.chair,
                        color: seatColor18 ? Colors.white : Colors.red)),
                IconButton(
                    onPressed: () {
                      setState(() {
                        seatColor19 = !seatColor19;
                        print(seatColor15);
                      });
                    },
                    icon: Icon(Icons.chair,
                        color: seatColor19 ? Colors.white : Colors.red)),
                IconButton(
                    onPressed: () {
                      setState(() {
                        seatColor20 = !seatColor20;
                        print(seatColor15);
                      });
                    },
                    icon: Icon(Icons.chair,
                        color: seatColor20 ? Colors.white : Colors.red)),
                Text(
                  'B',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                )
              ],
            ),
            SizedBox(height: 30),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'A',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        seatColor21 = !seatColor21;
                        print(seatColor15);
                      });
                    },
                    icon: Icon(Icons.chair,
                        color: seatColor21 ? Colors.white : Colors.red)),
                IconButton(
                    onPressed: () {
                      setState(() {
                        seatColor22 = !seatColor22;
                        print(seatColor15);
                      });
                    },
                    icon: Icon(Icons.chair,
                        color: seatColor22 ? Colors.white : Colors.red)),
                IconButton(
                    onPressed: () {
                      setState(() {
                        seatColor23 = !seatColor23;
                        print(seatColor15);
                      });
                    },
                    icon: Icon(Icons.chair,
                        color: seatColor23 ? Colors.white : Colors.red)),
                IconButton(
                    onPressed: () {
                      setState(() {
                        seatColor24 = !seatColor24;
                        print(seatColor15);
                      });
                    },
                    icon: Icon(Icons.chair,
                        color: seatColor24 ? Colors.white : Colors.red)),
                IconButton(
                    onPressed: () {
                      setState(() {
                        seatColor25 = !seatColor25;
                        print(seatColor15);
                      });
                    },
                    icon: Icon(Icons.chair,
                        color: seatColor25 ? Colors.white : Colors.red)),
                Text(
                  'A',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                )
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.arrow_downward, size: 50, color: Colors.white),
                Icon(Icons.arrow_downward, size: 50, color: Colors.white),
              ],
            ),
            Text(
              'All Eyes this way please',
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
            SizedBox(
              height: 40,
            ),
            MaterialButton(
              onPressed: openCheckout,
              child: Text('Book tickets'),
              color: Colors.red,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              height: 60,
            ),
          ],
        ),
      ),
    );
  }
}
