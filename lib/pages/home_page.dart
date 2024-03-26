// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables


import 'package:vertical_card_pager/vertical_card_pager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './SerchDoner.dart';
import '../components/vertical_page.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //this selected index is to control bottom nav bar
  int _selectedIndex = 0;

  //this method will update out selected index

  //when the user taps on the bottom bar
  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final user = FirebaseAuth
      .instance.currentUser!; //to return the name or email of current user
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Color.fromARGB(255, 255, 255, 255),
      //   actions: [
      //     IconButton(
      //       onPressed: signUserOut,
      //       icon: Icon(
      //         Icons.logout,
      //         color: const Color.fromARGB(255, 0, 0, 0),
      //       ),
      //     ),
      //   ],
      // ),
      body: Column(
        children: [
          Expanded(
            child: VerticalPages(),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: ElevatedButton.icon(
              onPressed: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchWidget()),
                );
                 
              },
              icon: Icon( 
                Icons.search,
                color: Colors.white,
              ),
              label: Text(
                'Find Donor',
                style: TextStyle(fontSize: 19, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: Size(double.infinity, 50), // Increase the height of the button
              ),
          ),
      )],
      ),
      
    );
  }
}
