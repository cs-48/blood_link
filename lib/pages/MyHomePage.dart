import 'package:blood_link/pages/message_page.dart';
import 'package:blood_link/pages/status_page.dart';
import 'package:flutter/material.dart';
import 'package:blood_link/components/bottom_nav_bar.dart'; // Adjust the import path as needed
import 'home_page.dart';
import 'profile_page.dart';
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
 
  void _handleTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
     Widget selectedWidget;
  switch (_selectedIndex) {
    case 0:
      selectedWidget = Center(child: HomePage());
      break;
    case 3:
      selectedWidget = Center(child: ProfilePage());
      break;
    case 2:
      selectedWidget = Center(child: MessagePage());
      break;
    case 1:
      selectedWidget = Center(child: StatusPage());
      break;
    default:
      selectedWidget = Center(child: Text('Unknown'));
  }
    return Scaffold(
      appBar: AppBar(
        title: Text('Blood Link'),
        centerTitle: true,
      ),
      body: Center(
        child: selectedWidget,
      ),
      bottomNavigationBar: MyBottomNavBar(
        onTabChange: _handleTabChange,
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}
