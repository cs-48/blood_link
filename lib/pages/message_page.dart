import 'package:flutter/material.dart';
import 'chat_page.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  List<String> messages = [
    'Need O+ve blood near Trivandrum.',
    'Need O+ve blood near Chengannur.',
    'Need O+ve blood near Thiruvalla.',
  ];

  List<String> timestamps = [
    '2024-04-06 10:30:00',
    '2024-04-07 15:45:00',
    '2024-04-08 09:20:00',
  ];

  void acceptMessage(int index) {
    // Handle accept action
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChatPage(message: messages[index])),
    );
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
                    'Received on: ${timestamps[index]}',
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
                      // Handle reject action
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


