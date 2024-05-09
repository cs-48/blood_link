import 'package:flutter/material.dart';

class CallConnectingInterface extends StatelessWidget {
  void _endCall(BuildContext context) {
    Navigator.pop(context); // Pop the current route
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(20.0),
              ),
              padding: EdgeInsets.all(10.0),
              child: Icon(
                Icons.phone,
                color: Colors.white,
                size: 60.0,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Call is connecting...',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _endCall(context),
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: Padding(
    padding: const EdgeInsets.all(10.0),
    child: Text(
      'End Call',
      style: TextStyle(fontSize: 20, color: Colors.white),
    ),
  ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CallConnectingInterface(),
  ));
}
