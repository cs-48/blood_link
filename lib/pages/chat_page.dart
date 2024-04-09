import 'package:flutter/material.dart';
import 'message_page.dart';

class ChatPage extends StatelessWidget {
  final String message;

  const ChatPage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Page'),
      ),
      body: Center(
        child: Text('Chatting about: $message'),
      ),
    );
  }
}
