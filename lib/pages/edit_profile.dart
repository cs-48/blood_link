import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _healthFactorsController = TextEditingController();

  late String _uid;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _uid = user.uid;
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(_uid).get();
      if (userDoc.exists) {
        setState(() {
          _nameController.text = userDoc['name'];
          _emailController.text = userDoc['email'];
          _placeController.text = userDoc['place'];
          _heightController.text = userDoc['height'].toString();
          _weightController.text = userDoc['weight'].toString();
          _healthFactorsController.text = userDoc['healthFactors'].join(', ');
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name'),
            TextField(controller: _nameController),
            SizedBox(height: 16.0),
            Text('Email'),
            TextField(controller: _emailController),
            SizedBox(height: 16.0),
            Text('Place'),
            TextField(controller: _placeController),
            SizedBox(height: 16.0),
            Text('Height (cm)'),
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            Text('Weight (kg)'),
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            Text('Health Factors'),
            TextField(controller: _healthFactorsController),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _updateUserData();
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateUserData() async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(_uid).update({
        'name': _nameController.text,
        'email': _emailController.text,
        'place': _placeController.text,
        'height': int.parse(_heightController.text),
        'weight': int.parse(_weightController.text),
        'healthFactors': _healthFactorsController.text.split(',').map((e) => e.trim()).toList(),
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile updated successfully')));
    } catch (error) {
      print('Error updating profile: $error');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update profile')));
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _placeController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _healthFactorsController.dispose();
    super.dispose();
  }
}
