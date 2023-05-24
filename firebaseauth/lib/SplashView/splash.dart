import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauth/HomeView/home.dart';
import 'package:firebaseauth/SignInView/signin.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const SplashView());
}

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      Timer(
          const Duration(seconds: 3),
          (() => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: ((context) => const HomeView())))));
    } else {
      Timer(
          const Duration(seconds: 3),
          (() => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: ((context) => const SignInView())))));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Icon(
        Icons.facebook,
        size: 70,
        color: Color(0xff3b5998),
      )),
    );
  }
}
