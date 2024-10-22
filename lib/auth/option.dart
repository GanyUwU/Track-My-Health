
import 'package:fit_try/auth/register.dart';
import 'package:fit_try/auth/sign_in.dart';
import 'package:flutter/material.dart';

class Option extends StatefulWidget {
  const Option({super.key});

  @override
  State<Option> createState() => _OptionState();
}

class _OptionState extends State<Option> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(

                  onPressed: ()
                {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>Register())
                  );
                },
                  child: Text('Register'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 150, vertical: 20),
                  backgroundColor: Colors.lightGreen,
                  foregroundColor: Colors.black,
                    textStyle: MaterialStateTextStyle.resolveWith((states) {
                      if(states.contains(MaterialState.pressed)) {
                       return TextStyle(fontSize: 20);
                      }
                      return TextStyle(fontSize: 15);
                     }),
                  ),
                ),
              ),
              ElevatedButton(onPressed: ()
              {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>SignIn())
                );
              },
                child: Text('Login'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 160, vertical: 20),
                  backgroundColor: Colors.lightGreen,
                  foregroundColor: Colors.black,
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
        )
    );
  }
}
