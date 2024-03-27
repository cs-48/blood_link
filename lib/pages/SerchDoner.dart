import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  List<Doner> doners = [
    Doner(name: 'Arun', place: 'Thiruvananthapuram', bloodGroup: 'A+'),
    Doner(name: 'Anu', place: 'Kochi', bloodGroup: 'B-'),
    Doner(name: 'Manoj', place: 'Kozhikode', bloodGroup: 'O+'),
    Doner(name: 'Sneha', place: 'Thrissur', bloodGroup: 'AB+'),
    Doner(name: 'Rahul', place: 'Kollam', bloodGroup: 'A-'),
    Doner(name: 'Deepa', place: 'Alappuzha', bloodGroup: 'B+'),
    Doner(name: 'Suresh', place: 'Palakkad', bloodGroup: 'O-'),
    Doner(name: 'Divya', place: 'Kannur', bloodGroup: 'AB-'),
  ];

  List<Doner> filteredDoners = [];

  void filterDoners(String query) {
    setState(() {
      filteredDoners = doners
          .where((doner) =>
              doner.place.toLowerCase().contains(query.toLowerCase()) ||
              doner.bloodGroup.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donor Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: filterDoners,
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey[200],
                hintText: 'Search by location or blood group',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredDoners.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredDoners[index].name),
                  subtitle: Text(
                    'Place: ${filteredDoners[index].place}, Blood Group: ${filteredDoners[index].bloodGroup}',
                  ),
                  tileColor: index % 2 == 0 ? Colors.grey[200] : Colors.white,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  trailing: Icon(Icons.arrow_forward),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Doner {
  final String name;
  final String place;
  final String bloodGroup;

  Doner({required this.name, required this.place, required this.bloodGroup});
}