import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  final String message;
  final String seeker;
  final String requestId;

  const ChatScreen({Key? key, required this.message, required this.seeker, required this.requestId}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late FirebaseAuth _auth;
  late FirebaseFirestore _firestore;
  late TextEditingController _messageController;
  List<Message> messages = [];

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _firestore = FirebaseFirestore.instance;
    _messageController = TextEditingController();
    _fetchMessages();
  }

  void _fetchMessages() async {
    String? currentUserUid = _auth.currentUser?.uid;
    if (currentUserUid != null) {
      QuerySnapshot querySnapshot = await _firestore
          .collection('requests')
          .doc(widget.requestId)
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .get();
      List<Message> fetchedMessages = [];
      querySnapshot.docs.forEach((doc) {
        fetchedMessages.add(Message(
          message: doc['message'],
          time: doc['timestamp'],
          senderId: doc['senderId'],
        ));
      });
      setState(() {
        messages = fetchedMessages;
      });
    }
  }

  void _sendMessage() async {
    String? currentUserUid = _auth.currentUser?.uid;
    if (currentUserUid != null) {
      await _firestore.collection('requests').doc(widget.requestId).collection('messages').add({
        'message': _messageController.text,
        'senderId': currentUserUid,
        'timestamp': FieldValue.serverTimestamp(),
      });
      _messageController.clear();
      _fetchMessages();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Screen'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return ListTile(
                  title: Text('${message.senderId}: ${message.message}'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final String message;
  final Timestamp time;
  final String senderId;

  Message({required this.message, required this.time, required this.senderId});
}
