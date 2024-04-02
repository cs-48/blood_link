// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:blood_link/pages/register_as_donor.dart';

// class EditProfile extends StatefulWidget {
//   const EditProfile({super.key});

//   @override
//   State<EditProfile> createState() => _EditProfileState();
// }

// class _EditProfileState extends State<EditProfile> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Edit Profile'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Name'),
//             TextField(controller: _nameController),
//             SizedBox(height: 16.0),
//             Text('Email'),
//             TextField(controller: _emailController),
//             SizedBox(height: 16.0),
//             Text('Profile Image'),
//             TextField(controller: _profileImageController),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () {
//                 // Submit the form data
//               },
//               child: Text('Submit'),
//             ),
//           ],
//         ),
//       ),


//     );
//   }
// }