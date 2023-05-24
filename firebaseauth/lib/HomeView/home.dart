import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauth/SignInView/signin.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const HomeView());
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              'Facebook Home Page',
              style: TextStyle(
                  fontSize: 30,
                  color: Color(0xff3b5998),
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.9,
            child: ElevatedButton(
              onPressed: () async {
                await _auth.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: ((context) => SignInView())));
              },
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
                  elevation: MaterialStateProperty.all(0)),
              child: const Text(
                'Sign Out',
                style: TextStyle(fontSize: 21),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
