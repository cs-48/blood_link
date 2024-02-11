// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:blood_link/pages/auth_page.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});
  @override
  State<IntroPage> createState() => _IntroPageState();
}
class _IntroPageState extends State<IntroPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => AuthPage(),
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // logo
          Center(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image.asset(
                'lib/images/BloodLink_logo-removebg.png',
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          //title
          const Text(
            'Download.. Donate.. Deliver Hope..',
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontFamily: 'Helvetica',
              fontSize: 20,
            ),
          ),
          //sub title if needed
        ],
      ),
    );
  }
}