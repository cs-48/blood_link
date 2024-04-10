import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  String _selectedBloodGroup = 'A+'; // Set an initial value
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
                    _healthFactorsController.clear();
                  });
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Submit the form data
                  if (_selectedBloodGroup.isNotEmpty &&
                      _placeController.text.isNotEmpty &&
                      _heightController.text.isNotEmpty &&
                      _weightController.text.isNotEmpty) {
                    setState(() {
                      _allFieldsFilled = true;
                    });
                    Navigator.pop(context, true); // Return true when all required fields are filled
                  } else {
                    setState(() {
                      _allFieldsFilled = false;
                    });
                  }
                },
                child: Text('Submit'),
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
