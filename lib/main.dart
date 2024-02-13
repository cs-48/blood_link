// ignore_for_file: prefer_const_constructors

import 'package:blood_link/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:blood_link/pages/intro_page.dart';
import 'package:flutter/material.dart';
//haiida
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroPage(),
    );
  }
}
