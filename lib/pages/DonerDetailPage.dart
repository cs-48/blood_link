import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'SerchDoner.dart';

class DonerDetailPage extends StatefulWidget {
  final Doner doner;

  const DonerDetailPage({Key? key, required this.doner}) : super(key: key);

  @override
  State<DonerDetailPage> createState() => _DonerDetailPageState();
}

class _DonerDetailPageState extends State<DonerDetailPage> {
  bool connected = false; // Track connection status

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doner Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Name: ${widget.doner.name}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 8),
            Text(
              'Place: ${widget.doner.place}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 8),
            Text(
              'Blood Group: ${widget.doner.bloodGroup}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _sendRequestToConnect();
                setState(() {
                  connected = !connected; // Toggle connection status
                });
              },
              child: Text(connected ? 'Pending ' : 'Connect'),
            ),
          ],
        ),
      ),
    );
  }

  void _sendRequestToConnect() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    String? currentUserUid = auth.currentUser?.uid;

    if (currentUserUid != null) {
      await firestore.collection('requests').add({
        'doner': widget.doner.uid,
        'seeker': currentUserUid,
        'status': 'pending',
      });
    }
  }
}
