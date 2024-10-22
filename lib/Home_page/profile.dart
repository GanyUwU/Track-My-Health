import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              CircleAvatar(
                radius: 70,
                child: ClipOval(
                  child: Image.asset('assets/female.png'),
                ),
              ),
              SizedBox(height: 20),
              itemProfile('Name', 'Apurva Ambre', Icons.person),
              SizedBox(height: 20),
              itemProfile("Phone Number", "9876543210", Icons.phone),
              SizedBox(height: 20),
              itemProfile("Email", "abc123@gmail.com", Icons.email),
              SizedBox(height: 20),
              itemProfile("Age", "20 years", Icons.cake),
              SizedBox(height: 20),
              itemProfile("Height", "5 ft 4 inches", Icons.height),
              SizedBox(height: 20),
              itemProfile("Weight", "50 kgs", Icons.monitor_weight),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () { },
                child: Text("Edit Profile"),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(horizontal: 20,vertical: 18)),
                  backgroundColor: MaterialStateProperty.all(Colors.green.shade900),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  elevation: MaterialStateProperty.all<double>(5.0),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                  textStyle: MaterialStateTextStyle.resolveWith((states) {
                    if(states.contains(MaterialState.pressed)) {
                      return TextStyle(fontSize: 20);
                    }
                    return TextStyle(fontSize: 15);
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  itemProfile(String title, String subtitle, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 7),
                color: Colors.green.shade900.withOpacity(.3),
                spreadRadius: 2,
                blurRadius: 10
            )
          ]
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
        tileColor: Colors.white,
      ),
    );
  }
}
