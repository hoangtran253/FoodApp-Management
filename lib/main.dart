import 'package:flutter/material.dart';
import 'package:food_app/pages/bottomnav.dart';
import 'package:food_app/pages/home.dart';
import 'package:food_app/pages/onboard.dart';
import 'package:food_app/pages/signup.dart';
import 'pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyBTCgbdpK2_j-wDj8qMwJBBlyQXHBI1CSo",
    authDomain: "foodapp-7723b.firebaseapp.com",
    projectId: "foodapp-7723b",
    storageBucket: "foodapp-7723b.firebasestorage.app",
    messagingSenderId: "583114285011",
    appId: "1:583114285011:web:1bdc4e70d163b8a81c9926",
    measurementId: "G-LQ3GYGHH1T",
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food App',
      home: Onboard(),
    );
  }
}
