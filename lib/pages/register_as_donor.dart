import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegDonor extends StatefulWidget {
  const RegDonor({Key? key}) : super(key: key);

  @override
  State<RegDonor> createState() => _RegDonorState();
}

class _RegDonorState extends State<RegDonor> {
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _healthFactorsController = TextEditingController();

  String _selectedBloodGroup = 'A+';
  List<String> _bloodGroups = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
  List<String> _healthFactors = [];

  bool _allFieldsFilled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register as Donor'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Blood Group'),
              DropdownButtonFormField<String>(
                value: _selectedBloodGroup,
                items: _bloodGroups.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedBloodGroup = value!;
                  });
                },
              ),
              SizedBox(height: 16.0),
              Text('Place'),
              TextField(controller: _placeController),
              SizedBox(height: 16.0),
              Text('Height (cm)'),
              TextField(
                controller: _heightController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              SizedBox(height: 16.0),
              Text('Weight (kg)'),
              TextField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              SizedBox(height: 16.0),
              Text('Other Health Factors'),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: _healthFactors.map((factor) {
                  return Chip(
                    label: Text(factor),
                    onDeleted: () {
                      setState(() {
                        _healthFactors.remove(factor);
                      });
                    },
                  );
                }).toList(),
              ),
              TextField(
                controller: _healthFactorsController,
                onSubmitted: (value) {
                  setState(() {
                    _healthFactors.add(value);
                    // _healthFactorsController.clear();
                  });
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_selectedBloodGroup.isNotEmpty &&
                      _placeController.text.isNotEmpty &&
                      _heightController.text.isNotEmpty &&
                      _weightController.text.isNotEmpty) {
                    // All required fields are filled
                    setState(() {
                      _allFieldsFilled = true;
                    });
                    // Get the UID of the authenticated user
                    String uid = FirebaseAuth.instance.currentUser!.uid;
                    // Update the specific document in the users collection with donor details
                    FirebaseFirestore.instance.collection('users').doc(uid).update({
                      'donor': true,
                      'bloodGroup': _selectedBloodGroup,
                      'place': _placeController.text,
                      'height': int.parse(_heightController.text),
                      'weight': int.parse(_weightController.text),
                      'healthFactors': _healthFactors,
                    }).then((_) {
                      // Clear the form fields
                      // _placeController.clear();
                      // _heightController.clear();
                      // _weightController.clear();
                      // _healthFactors.clear();
                      // _healthFactorsController.clear();
                      // Navigate back
                      Navigator.pop(context, true);
                    }).catchError((error) {
                      // Handle error
                      print('Error updating donor details: $error');
                    });
                  } else {
                    setState(() {
                      _allFieldsFilled = false;
                    });
                  }
                },
                child: Text('Submit'),
              ),
              if (!_allFieldsFilled)
                Text(
                  'Please fill in all required fields.',
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _placeController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _healthFactorsController.dispose();
    super.dispose();
  }
}
