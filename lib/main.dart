// for the login with email and the password

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutterproject/admin/adminhome.dart';
import 'package:flutterproject/moviehomescreen.dart';
import 'package:flutterproject/provider/userprovider.dart';
import 'package:flutterproject/signup.dart';
import 'package:flutterproject/splash.dart';
import 'package:provider/provider.dart';
//import 'firebase_options.dart';
import 'detailsPage.dart';
import 'login.dart';
import 'newLogin.dart' as loger;
import 'package:flutterproject/homeScreen.dart';
import 'package:flutterproject/dashBoard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String fullname = "";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
      fullname = (snap.data() as Map<String, dynamic>)['fullName'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        //for the Auth persistance we use the streambuilder

        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData && fullname == 'admin') {
                  print(fullname);
                  return adminHome();
                } else if (snapshot.hasData) {
                  return MovieHome();
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error}'),
                  );
                } // if for snapshot
              } // if condition
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              } // for waiting if
              return splash();
            }),

        //  home: MovieHomeScreen(),
        // initialRoute: '/home',
        /*  routes: {
            '/': (context) => MovieHomeScreen(),
            '/home': (context) => MovieApp(),
            '/details': (context) => DetailsPage(),
            '/login': (context) => LoginPage(),
            '/signup': (context) => newLogin(),
            '/newsingup': (context) => singUp(),
          },
          */
      ),
    );
  }
}
