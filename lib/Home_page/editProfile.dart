import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  String _gender = 'male'; // Default gender

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  // Step 2: Fetch User Data from Firestore
  Future<void> _fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

      if (userData.exists) {
        // Set the retrieved data to controllers
        _nameController.text = userData['name'] ?? '';
        _ageController.text = userData['age']?.toString() ?? '';
        _weightController.text = userData['weight']?.toString() ?? '';
        _heightController.text = userData['height']?.toString() ?? '';
        _gender = userData['gender'] ?? 'male'; // Default to 'male'
      }
    }
  }

  // Step 3: Update User Profile
  Future<void> _updateProfile() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'name': _nameController.text,
        'age': int.tryParse(_ageController.text) ?? 0,
        'weight': double.tryParse(_weightController.text) ?? 0.0,
        'height': double.tryParse(_heightController.text) ?? 0.0,
        'gender': _gender,
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile updated successfully!')));
      Navigator.pop(context); // Go back to the previous screen
    } else {
      print('No user is signed in.');
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
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _weightController,
              decoration: InputDecoration(labelText: 'Weight (kg)'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            TextField(
              controller: _heightController,
              decoration: InputDecoration(labelText: 'Height (cm)'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            DropdownButton<String>(
              value: _gender,
              onChanged: (String? newValue) {
                setState(() {
                  _gender = newValue!;
                });
              },
              items: <String>['male', 'female']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateProfile,
              child: Text('Update Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
