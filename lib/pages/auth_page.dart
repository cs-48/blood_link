import 'package:blood_link/pages/intro_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import "MyHomePage.dart";
import 'login_or_register_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //user is logged in
          if (snapshot.hasData) {  //snapshot.hasData  //ture
            return MyHomePage();
          }

          //user is NOT logged in
          else {
            return LoginOrRegisterPage();
          }
        },
      )
    );
  }
}
