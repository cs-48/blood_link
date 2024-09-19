import 'dart:math';
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
  final List<Donation> donations = List.generate(
    Random().nextInt(10) + 1, // Random number of donations between 1 and 10
    (index) => Donation(
      id: Random().nextInt(1000) + 1, // Random ID between 1 and 1000
      completed: Random().nextBool(), // Random completion status
      date: DateTime.now().subtract(Duration(days: Random().nextInt(365))), // Random date within the last year
    ),
  );

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
                final color = donation.completed
                    ? Color.fromARGB(255, 253, 253, 253)
                    : Color.fromARGB(255, 244, 231, 211);
                return Card(
                  color: color,
                  elevation: 3.0,
                  child: ListTile(
                    title: Text('Donation ID: ${donation.id}'),
                    subtitle: Text('Completed: ${donation.completed}'),
                    trailing: donation.completed
                        ? Icon(Icons.add_task_rounded, color: Colors.green)
                        : Icon(Icons.assignment_late, color: Colors.orange),
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
    final difference =
        lastDonationDate != null ? currentDate.difference(lastDonationDate).inDays : null;

    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            difference != null && difference >= 90
                ? Color.fromARGB(255, 29, 230, 79)
                : Color.fromARGB(255, 255, 0, 0),
            difference != null && difference >= 90
                ? Color.fromARGB(255, 50, 72, 10)
                : Color.fromARGB(255, 102, 22, 22),
          ],
        ),
      ),
      child: Center(
        child: Text(
          difference != null && difference >= 90
              ? 'Eligible for donation'
              : 'Not eligible for donation',
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
          ),
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
    final difference =
        lastDonationDate != null ? currentDate.difference(lastDonationDate).inDays : null;
    final remainingDays = difference != null && difference < 90 ? 90 - difference : null;

    return remainingDays != null
        ? Center(child: Text("Remaining days for next donation: $remainingDays days"))
        : SizedBox.shrink();
  }
}

void main() {
  runApp(MaterialApp(
    home: StatusPage(),
  ));
}
