import 'package:flutter/material.dart';
class StatusPage extends StatefulWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class Donation {
  final int id;
  final bool completed;
  final DateTime date;

  Donation({
    required this.id,
    required this.completed,
    required this.date,
  });
}

class _StatusPageState extends State<StatusPage> {
  final List<Donation> donations = [
    Donation(id: 1, completed: true, date: DateTime(2024, 1, 20)),
    Donation(id: 2, completed: false, date: DateTime(2024, 2, 25)),
    Donation(id: 3, completed: true, date: DateTime(2024, 3, 27)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Blood Donation Status')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: donations.length,
              itemBuilder: (context, index) {
                final donation = donations[index];
                final color = donation.completed ? Color.fromARGB(255, 253, 253, 253) : Color.fromARGB(255, 244, 231, 211);
                return Card(
                  color: color,
                  elevation: 3.0,
                  child: ListTile(
                    title: Text('Donation ID: ${donation.id}'),
                    subtitle: Text('Completed: ${donation.completed}'),
                    trailing: donation.completed
                        ? Icon(Icons.add_task_rounded, color: Colors.green) // Tick icon for completed donation
                        : Icon(Icons.assignment_late, color: Colors.orange), // Wait icon for pending donation
                    ),
                  );
              },
            ),
          ),
          DonationEligibility(donations: donations),
          SizedBox(height: 16),
          RemainingDays(donations: donations),
        ],
      ),
    );
  }
}

class DonationEligibility extends StatelessWidget {
  final List<Donation> donations;

  DonationEligibility({required this.donations});

  @override
  Widget build(BuildContext context) {
    final lastDonationDate = donations.isEmpty ? null : donations.last.date;
    final currentDate = DateTime.now();
    final difference = lastDonationDate != null ? currentDate.difference(lastDonationDate).inDays : null;

    return Container(
      padding: EdgeInsets.all(16.0),
      color: difference != null && difference >= 90 ? Colors.green : Colors.red,
      child: Center(
        child: Text(
          difference != null && difference >= 90 ? 'Eligible for donation' : 'Not eligible for donation',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class RemainingDays extends StatelessWidget {
  final List<Donation> donations;

  RemainingDays({required this.donations});

  @override
  Widget build(BuildContext context) {
    final lastDonationDate = donations.isEmpty ? null : donations.last.date;
    final currentDate = DateTime.now();
    final difference = lastDonationDate != null ? currentDate.difference(lastDonationDate).inDays : null;
    final remainingDays = difference != null && difference < 90 ? 90 - difference : null;

    return remainingDays != null
        ? Center(
            child: Text("Remaining days for next donation: $remainingDays days")
          )
        : SizedBox.shrink();
  }
}

void main() {
  runApp(MaterialApp(
    home: StatusPage(),
  ));
}
