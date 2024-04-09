import 'package:flutter/material.dart';
class ChatScreen extends StatelessWidget {
  final String message;

  const ChatScreen({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Screen'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: Text('User A: Hello, I can help with your request.'),
                ),
                ListTile(
                  title: Text('User B: That would be great!'),
                ),
                // Add more messages here...
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // Send message functionality
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
