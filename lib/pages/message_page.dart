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
  List<Message> messages = [];

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
          .where('status', whereIn: ['pending', 'accepted']) // Fetch both pending and accepted requests
          .get();
      List<Message> fetchedMessages = [];
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?; // Cast to Map<String, dynamic>?
        if (doc.exists && data != null && data.containsKey('message') && data.containsKey('time')) {
          if (data['doner'] == currentUserUid || data['seeker'] == currentUserUid) {
            fetchedMessages.add(Message(
              message: data['message'],
              time: data['time'],
              status: data['status'],
              seeker: data['seeker'],
              reqId: data['reqid'], // Add request ID
            ));
          }
        }
      });
      setState(() {
        messages = fetchedMessages;
      });
    }
  }

  void acceptMessage(Message message) async {
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
          if (data['message'] == message.message && data['time'] == message.time) {
            doc.reference.update({'status': 'accepted','acceptedTime':FieldValue.serverTimestamp()});
          }
        }
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChatScreen(message: message.message, seeker: message.seeker, requestId: message.reqId)),
      ).then((_) {
        setState(() {
          messages.remove(message);
        });
      });
    }
  }

  void rejectMessage(Message message) {
    // Handle reject action
    setState(() {
      messages.remove(message);
    });
  }

  void viewAcceptedRequest(Message message) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChatScreen(message: message.message, seeker: message.seeker, requestId: message.reqId)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: ListView.builder(
        reverse: true,
        itemCount: messages.length,
        itemBuilder: (BuildContext context, int index) {
          final message = messages[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(message.message),
                  Text(
                    'Request Send Time: ${message.time}',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  message.status == 'pending'
                      ? TextButton(
                          onPressed: () {
                            acceptMessage(message);
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 128, 234, 132)),
                            textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(color: Colors.white)),
                          ),
                          child: Text('Accept'),
                        )
                      : SizedBox(), // Hide accept button if status is not pending
                  SizedBox(width: 8.0),
                  message.status == 'pending'
                      ? TextButton(
                          onPressed: () {
                            rejectMessage(message);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Rejected message ${index + 1}'),
                            ));
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 255, 84, 72)),
                            textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(color: Colors.white)),
                          ),
                          child: Text('Reject'),
                        )
                      : SizedBox(), // Hide reject button if status is not pending
                  SizedBox(width: 16.0),
                  message.status == 'accepted'
                      ? TextButton(
                          onPressed: () {
                            viewAcceptedRequest(message);
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                            textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(color: Colors.white)),
                          ),
                          child: Text('Chat'),
                        )
                      : SizedBox(), // Hide chat button if status is not accepted
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class Message {
  final String message;
  final String time;
  final String status;
  final String seeker;
  final String reqId; // Add request ID field

  Message({required this.message, required this.time, required this.status, required this.seeker, required this.reqId});
}
