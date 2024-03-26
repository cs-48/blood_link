import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ProfilePage extends StatelessWidget {
 void signUserOut() {
    FirebaseAuth.instance.signOut();
  }
  @override

  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Profile')),// remove when the profile page building is completed
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Align fields to the center
          children: [
            Align(
              alignment: Alignment.topCenter, // Align profile image to the top center
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('lib/images/512x512.png'),
              ),
            ),
            SizedBox(height: 20),
            Center( // Align username to the center
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16), // Add horizontal padding
                child: Text(
                  'Username',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16), // Add horizontal padding
              child: Row( // Align email, height, weight, blood group, and date of birth to the left
                children: [
                  Text(
                    'Email: ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 8), // Add space after the header
                  Text(
                    'example@example.com',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16), // Add horizontal padding
              child: Row( // Align height, weight, blood group, and date of birth to the left
                children: [
                  Text(
                    'Height: ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 8), // Add space after the header
                  Text(
                    '180 cm',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16), // Add horizontal padding
              child: Row( // Align height, weight, blood group, and date of birth to the left
                children: [
                  Text(
                    'Weight: ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 8), // Add space after the header
                  Text(
                    '70 kg',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16), // Add horizontal padding
              child: Row( // Align height, weight, blood group, and date of birth to the left
                children: [
                  Text(
                    'Blood Group: ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 8), // Add space after the header
                  Text(
                    'O+',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16), // Add horizontal padding
              child: Row( // Align height, weight, blood group, and date of birth to the left
                children: [
                  Text(
                    'Date of Birth: ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 8), // Add space after the header
                  Text(
                    '01/01/1990',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16), // Add horizontal padding
              child: Row( // Align height, weight, blood group, and date of birth to the left
                children: [
                  Text(
                    'Other Health Factors: ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 8), // Add space after the header
                  Text(
                    'Some other health factors',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // Align fields to the center
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16), // Add horizontal padding
                  child: Text('Register as a donor'),
                ),
                Switch(
                  value: false, // Replace with your logic to toggle the button
                  onChanged: (value) {
                    // Add your logic here to handle the toggle button
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Edit Profile',
                    style: TextStyle(fontSize: 19, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: Size(double.infinity, 50), // Increase the height of the button
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: ElevatedButton.icon(
                  onPressed: signUserOut ,
                  icon: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Logout',
                    style: TextStyle(fontSize: 19, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: Size(double.infinity, 50), // Increase the height of the button
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}