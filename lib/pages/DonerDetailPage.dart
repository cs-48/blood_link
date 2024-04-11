import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'SerchDoner.dart';
import 'package:crypto/crypto.dart';

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
      // Create a unique reqid using a hash of both UIDs
      String reqid = _generateReqId(currentUserUid, widget.doner.uid);

      // Get the current time in the desired format
      String currentTime = DateTime.now().toString();

      // Check if the entry already exists
      QuerySnapshot querySnapshot = await firestore
          .collection('requests')
          .where('reqid', isEqualTo: reqid)
          .get();

      if (querySnapshot.docs.isEmpty) {
        await firestore.collection('requests').add({
          'doner': widget.doner.uid,
          'seeker': currentUserUid,
          'status': 'pending',
          'reqid': reqid,
          'time': currentTime, // Add current time to the document
        });
      }
    }
  }

  String _generateReqId(String uid1, String uid2) {
    List<String> uids = [uid1, uid2];
    uids.sort(); // Sort the UIDs to ensure consistency
    String concatenatedUids = uids.join('');
    var bytes = utf8.encode(concatenatedUids);
    var hash = sha256.convert(bytes);
    return hash.toString();
  }
}
