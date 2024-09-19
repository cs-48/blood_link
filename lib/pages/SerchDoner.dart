import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Add this import
import 'DonerDetailPage.dart';

// Define the Doner class outside of the SearchWidget class
class Doner {
  final String uid;
  final String name;
  final String place;
  final String bloodGroup;

  Doner({required this.uid, required this.name, required this.place, required this.bloodGroup});
}

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  List<Doner> doners = []; // Initialize an empty list

  List<Doner> filteredDoners = [];

  void filterDoners(String query) {
    setState(() {
      filteredDoners = doners
          .where((doner) =>
              doner.place.toLowerCase().contains(query.toLowerCase()) ||
              doner.name.toLowerCase().contains(query.toLowerCase()) ||
              doner.bloodGroup.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    getDonersFromFirebase();
  }

  void getDonersFromFirebase() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('donor', isEqualTo: true)
        .get();

    List<Doner> fetchedDoners = [];
    querySnapshot.docs.forEach((doc) {
      fetchedDoners.add(Doner(
       
        name: doc['name'] ?? 'Anonymous_${DateTime.now().millisecondsSinceEpoch}',
        place: doc['place'],
        bloodGroup: doc['bloodGroup'],
         uid: doc['uid'],
      ));
    });

    setState(() {
      doners = fetchedDoners;
      filteredDoners = doners;
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
      contentPadding:
          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      trailing: Icon(Icons.arrow_forward),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DonerDetailPage(doner: filteredDoners[index]),
          ),
        );
      },
    );
  },
),
          ),
        ],
      ),
    );
  }
}
