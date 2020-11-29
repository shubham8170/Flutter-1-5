import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Signin extends StatefulWidget {
  Signin({Key key}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  //final _auth = FirebaseAuth.instance;
  // ignore: deprecated_member_use
  final _firestore = Firestore.instance;
  String password;
  String email;
  //Future signInUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration:
                    InputDecoration(hintText: 'email', labelText: 'email'),
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: 'password', labelText: 'password'),
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
                obscureText: true,
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                child: Text('Sign Up'),
                onPressed: () {
                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: email, password: password)
                      .then((signedInUser) {
                    _firestore.collection('users').add({
                      'email': email,
                      'pass': password,
                    }).then((value) {
                      //if (signedInUser != null) {
                      Navigator.pushNamed(context, '/homepage');
                      //}
                    }).catchError((e) {
                      print(e);
                    });
                  }).catchError((e) {
                    print(e);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
