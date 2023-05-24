import 'package:firebaseauth/HomeView/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(const SignInView());
}

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  TextEditingController emaillController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  register() async {
    final String email = emaillController.text;
    final String password = passwordController.text;
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: ((context) => HomeView())));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('The password provided is too weak.'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Color.fromARGB(255, 129, 144, 142),
        ));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('The account already exists for that email.'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Color.fromARGB(255, 129, 144, 142),
        ));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xff3b5998),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'facebook',
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: width * 0.9,
                padding: const EdgeInsets.only(top: 3, bottom: 3, left: 15),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: TextField(
                  controller: emaillController,
                  decoration: const InputDecoration(
                      hintText: ' Your email address',
                      border: InputBorder.none),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: width * 0.9,
                padding: const EdgeInsets.only(top: 3, bottom: 3, left: 15),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: TextField(
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: const InputDecoration(
                      hintText: ' Your Password', border: InputBorder.none),
                ),
              ),
              Container(
                width: width * 0.9,
                height: 53,
                margin: const EdgeInsets.only(top: 10),
                child: ElevatedButton(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      )),
                  onPressed: register,
                  child: const Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white, fontSize: 21),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
