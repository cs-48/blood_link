import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'chat_page.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  late FirebaseAuth _auth;
  late FirebaseFirestore _firestore;
  List<String> messages = [];
  List<String> timestamps = [];

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _firestore = FirebaseFirestore.instance;
    _fetchRequests();
  }

  void _fetchRequests() async {
    String? currentUserUid = _auth.currentUser?.uid;
    if (currentUserUid != null) {
      QuerySnapshot querySnapshot = await _firestore
          .collection('requests')
          .where('doner', isEqualTo: currentUserUid)
          .where('status', isEqualTo: 'pending')
          .get();
      List<String> fetchedMessages = [];
      List<String> fetchedTimestamps = [];
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?; // Cast to Map<String, dynamic>?
        if (doc.exists && data != null && data.containsKey('message') && data.containsKey('time')) {
          fetchedMessages.add(data['message']);
          fetchedTimestamps.add(data['time']);
        }
      });
      setState(() {
        messages = fetchedMessages;
        timestamps = fetchedTimestamps;
      });
    }
  }

  void acceptMessage(int index) async {
    String? currentUserUid = _auth.currentUser?.uid;
    if (currentUserUid != null) {
      QuerySnapshot querySnapshot = await _firestore
          .collection('requests')
          .where('doner', isEqualTo: currentUserUid)
          .where('status', isEqualTo: 'pending')
          .get();
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?; // Cast to Map<String, dynamic>?
        if (doc.exists && data != null && data.containsKey('message') && data.containsKey('time')) {
          if (data['message'] == messages[index] && data['time'] == timestamps[index]) {
            doc.reference.update({'status': 'accepted'});
          }
        }
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChatScreen(message: messages[index])),
      );
    }
  }

  void rejectMessage(int index) {
    // Handle reject action
    setState(() {
      messages.removeAt(index);
      timestamps.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Message Notifications'),
      ),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(messages[index]),
                  Text(
                    'Request Send Time: ${timestamps[index]}',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      acceptMessage(index);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 128, 234, 132)),
                      textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(color: Colors.white)),
                    ),
                    child: Text('Accept'),
                  ),
                  SizedBox(width: 8.0),
                  TextButton(
                    onPressed: () {
                      rejectMessage(index);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Rejected message ${index + 1}'),
                      ));
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 255, 84, 72)),
                      textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(color: Colors.white)),
                    ),
                    child: Text('Reject'),
                  ),
                  SizedBox(width: 16.0),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
