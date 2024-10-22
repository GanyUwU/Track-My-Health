import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'editProfile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Store user data
  User? currentUser;
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  // Fetch user data from Firebase
  Future<void> _fetchUserData() async {
    try {
      User? user = _auth.currentUser; // Get the current user
      if (user != null) {
        // Fetch user document from Firestore
        DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();

        setState(() {
          currentUser = user;
          userData = userDoc.data() as Map<String, dynamic>?; // Store user data
        });
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: currentUser == null
          ? Center(child: CircularProgressIndicator()) // Loading state
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Picture (default image if not present)
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: userData?['profilePicture'] != null
                    ? NetworkImage(userData!['profilePicture'])
                    : AssetImage('assets/female.png') as ImageProvider,
              ),
            ),
            SizedBox(height: 20),

            // Display Name
            Text(
              "Name: ${userData?['name'] ?? 'N/A'}",
              style: TextStyle(fontSize: 18,),
            ),

            SizedBox(height: 10),

            // Email
            Text(
              "Email: ${currentUser?.email ?? 'N/A'}",
              style: TextStyle(fontSize: 18),
            ),

            SizedBox(height: 10),

            // Bio (if available)
            Text(
              "Weight: ${userData?['weight'] ?? 'N/A'}",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              "Height: ${userData?['height'] ?? 'N/A'}",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              "BMI: ${userData?['bmi'] ?? 'N/A'}",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              "Age: ${userData?['age'] ?? 'N/A'}",
              style: TextStyle(fontSize: 18),
            ),

            SizedBox(height: 20),

            // Logout Button
            Row(
              children: [
                ElevatedButton(onPressed: (){
                  Navigator.push(
                    context,
                     MaterialPageRoute(builder: (context) => EditProfile()),
                    );
                    }, child: Text("Edit")
                ),
                ElevatedButton(
                  onPressed: () async {
                    await _auth.signOut();
                    Navigator.of(context).pushReplacementNamed('/login');
                  },
                  child: Text("Logout"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
