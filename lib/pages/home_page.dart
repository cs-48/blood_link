import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './SerchDoner.dart';
import '../components/vertical_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final user = FirebaseAuth.instance.currentUser!;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  void addUserDetailsToFirestore() async {
    final usersCollection = FirebaseFirestore.instance.collection('users');
    print(user);                             
  String name;
    if (user.displayName == null) {
      name = "anonymous";
    } else {
      name = user.displayName!;
    }
    await usersCollection.doc(user.uid).set({
      'uid': user.uid,
      'name': user.email ,
      'email': user.email,
      // Add any other user details you want to store
    }, SetOptions(merge: true)); 
  }

  @override
  void initState() {
    super.initState();
    addUserDetailsToFirestore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
