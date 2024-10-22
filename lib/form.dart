import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_try/auth/option.dart';
import 'package:flutter/material.dart';

class NameStep extends StatefulWidget {
  const NameStep({super.key});

  @override
  State<NameStep> createState() => _NameStepState();
}

class _NameStepState extends State<NameStep> {
  final TextEditingController _nameController = TextEditingController();  // Controller for name input
  final FirebaseAuth _auth = FirebaseAuth.instance;  // Firebase Auth instance

  // Function to save the name to Firestore
  Future<void> _saveName() async {
    try {
      User? user = _auth.currentUser;  // Get current user

      if (user != null) {
        // Save name to Firestore under the user's UID
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'name': _nameController.text, // Save the entered name
        }, SetOptions(merge: true));

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Name saved successfully!')),
        );
      } else {
        // If no user is logged in, show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: No user logged in')),
        );
      }
    } catch (e) {
      // If there's an error saving, show an error message
      print('Error saving name: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving name')),
      );
    }
  }

  // Function to navigate to the next page
  void _goToNextPage() {
    if (_nameController.text.isNotEmpty) {
      _saveName();  // Save name to Firestore before navigating
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GenderSelection(),  // Assuming GenderSelection is your next step
        ),
      );
    } else {
      // Show error if the name field is empty
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please enter your name'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hey There!"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Text(
              "What is your name?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Name input field
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Enter your name',
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 16),
            // Button to go to the next page
            Container(
              width: 200.0,  // Set the desired width
              height: 50.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.orangeAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onPressed: _goToNextPage,  // Save and go to next page
                child: Text('Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



/*class Gender extends StatefulWidget {
  final String name;

  Gender({required this.name});

  @override
  State<Gender> createState() => _GenderState();
}

class _GenderState extends State<Gender> {
  final TextEditingController _nameController = TextEditingController();
  // This variable will hold the selected gender
  String _selectedGender = '';

  // Function to save the selection to Firestore or other database
  Future<void> _saveSelection(String gender) async {
    setState(() {
      _selectedGender = gender;
    });

    try {
      // Firestore example: Save the selected gender to the database
      await FirebaseFirestore.instance.collection('users').doc('user_id').set({
        'gender': gender,
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gender $gender saved successfully!')),
      );
    } catch (e) {
      print('Error saving gender: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving gender')),
      );
    }
  /*void _goToNextPage() {
    if (_nameController.text.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AgeStep(),
        ),
      );
    } else {
      // Show error if field is empty
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please select your gender'),
      ));
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 100,),
            const Align(
              alignment: Alignment.center,
              child: Text("What is your biological gender?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height:20,),

            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const AgeStep()));
                    },
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          ListTile(
                            title: Image.asset("assets/Male_symbol.png"),
                            subtitle: Text(
                              'Male',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 5,
                      margin: EdgeInsets.all(10),
                    ),
                  ),
                ),

                Expanded(
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const AgeStep()));
                    },
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 5,
                      margin: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          ListTile(
                            title: Image.asset("assets/Female_symbol.png"),
                            subtitle: const Text(
                              'Female',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]
            ),
          ],
        ),
      ),
    );
  }
}


*/

class GenderSelection extends StatefulWidget {
  const GenderSelection({super.key});

  @override
  _GenderSelectionState createState() => _GenderSelectionState();
}

class _GenderSelectionState extends State<GenderSelection> {
  // This variable will hold the selected gender
  String _selectedGender = '';
  final FirebaseAuth _auth = FirebaseAuth.instance; // Firebase Auth instance

  // Function to save the selection to Firestore or other database
  Future<void> _saveSelection(String gender) async {
    setState(() {
      _selectedGender = gender;
    });

    try {
      User? user = _auth.currentUser;

      if (user != null) {
        // Save gender to Firestore under the user's UID
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'gender': gender,
        }, SetOptions(merge: true));

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gender $gender saved successfully!')),
        );
      }
      else {
        print("No user logged in.");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: No user logged in')),
        );
      }
    }catch (e) {
      print('Error saving gender: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving gender')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Gender'),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Male Card
            GestureDetector(
              onTap: () => _saveSelection('Male'), // When clicked, save 'Male'
              child: Card(
                color: _selectedGender == 'Male' ? Colors.blue : Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Icon(Icons.male, size: 100, color: Colors.blue),
                      Text('Male', style: TextStyle(fontSize: 24)),
                    ],
                  ),
                ),
              ),
            ),
        
            SizedBox(height: 20), // Spacer between the two cards
        
            // Female Card
            GestureDetector(
              onTap: () => _saveSelection('Female'), // When clicked, save 'Female'
              child: Card(
                color: _selectedGender == 'Female' ? Colors.pink : Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Icon(Icons.female, size: 100, color: Colors.pink),
                      Text('Female', style: TextStyle(fontSize: 24)),
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton(onPressed: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=>AgeStep()));
            },
                child: Text("Next"),
            ),
          ],
        ),
      ),
    );
  }
}
class AgeStep extends StatefulWidget {
  const AgeStep({super.key});

  @override
  _AgeStepState createState() => _AgeStepState();
}

class _AgeStepState extends State<AgeStep> {
  final TextEditingController _ageController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance; // Firebase Auth instance

  // Function to save the selection to Firestore or other database
  Future<void> _saveSelection(String age) async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        // Save age to Firestore under the user's UID
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'age': age,
        }, SetOptions(merge: true)); // Merge to avoid overwriting other fields

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Age $age saved successfully!')),
        );
      } else {
        // Handle if no user is logged in
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: No user logged in')),
        );
      }
    } catch (e) {
      // Handle any errors that occur while saving
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving age: $e')),
      );
    }
  }

  // Function to navigate to the next page
  void _goToNextPage() {
    if (_ageController.text.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EmailStep(
            age: _ageController.text,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please enter your age'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: const Text(
                "What is your Age?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            TextFormField(
              controller: _ageController,
              decoration: InputDecoration(labelText: 'Enter your age'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_ageController.text.isNotEmpty) {
                  _saveSelection(_ageController.text); // Save the entered age
                  _goToNextPage(); // Navigate to the next page
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Please enter your age'),
                  ));
                }
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}



class EmailStep extends StatefulWidget {
  final String age;

  EmailStep({required this.age});

  @override
  _EmailStepState createState() => _EmailStepState();
}

class _EmailStepState extends State<EmailStep> {
  final TextEditingController _activity = TextEditingController();
  String? _selectedActivity;  // This will store the selected activity

  final FirebaseAuth _auth = FirebaseAuth.instance; // Firebase Auth instance

  // Function to save the activity selection to Firestore
  Future<void> _saveSelection() async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        // Save activity to Firestore under the user's UID
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'activity': _activity.text,  // Saving the actual text value
        }, SetOptions(merge: true));

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Activity ${_activity.text} saved successfully!')),
        );
      } else {
        // Handle the case when no user is logged in
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: No user logged in')),
        );
      }
    } catch (e) {
      // Error handling
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving activity: $e')),
      );
    }
  }

  // Function to navigate to the next page (Height page in this case)
  void _goToNextPage() {
    if (_activity.text.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Height(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please select an activity'),
      ));
    }
  }

  // Function to display the activity options
  Widget active(String title, String subtitle, String assetPath) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedActivity = title;  // Set the selected activity
          _activity.text = title;  // Set the selected activity to the controller
        });
      },
      child: Card(
        elevation: 4,
        color: _selectedActivity == title ? Colors.blue[100] : Colors.white,  // Highlight selected card
        child: ListTile(
          leading: Image.asset(assetPath, width: 50, height: 50),
          title: Text(
            title,
            style: TextStyle(
              fontWeight: _selectedActivity == title ? FontWeight.bold : FontWeight.normal,  // Bold the selected title
            ),
          ),
          subtitle: Text(subtitle),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: const Text(
                "How active are you?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            active("Sedentary", "Mostly sitting through the day", "assets/chair.png"),
            SizedBox(height: 20),
            active("Lightly active", "Mostly Standing through the day", "assets/chair.png"),
            SizedBox(height: 20),
            active("Moderately active", "Mostly walking around", "assets/chair.png"),
            SizedBox(height: 20),
            active("Very active", "Doing heavy physical activities", "assets/active.png"),
            SizedBox(height: 20),
            active("Super active", "Physical job, or twice-daily workouts", "assets/active.png"),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_activity.text.isNotEmpty) {
                  _saveSelection(); // Save the selected activity
                  _goToNextPage(); // Navigate to the next page
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please select an activity')),
                  );
                }
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

class Height extends StatefulWidget {
  const Height({super.key});

  @override
  State<Height> createState() => _HeightState();
}

class _HeightState extends State<Height> {
  final TextEditingController _heightController = TextEditingController(); // Controller for height input
  final FirebaseAuth _auth = FirebaseAuth.instance; // Firebase Auth instance

  // Function to save the height to Firestore
  Future<void> _saveHeight() async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        // Parse the height as a double before saving
        double? height = double.tryParse(_heightController.text);

        if (height != null) {
          // Save height as double to Firestore under the user's UID
          await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
            'height': height,  // Store the height as double
          }, SetOptions(merge: true));

          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Height ${_heightController.text} cm saved successfully!')),
          );
        } else {
          // Handle invalid input (not a number)
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Invalid height. Please enter a valid number.')),
          );
        }
      } else {
        // Handle the case when no user is logged in
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: No user logged in')),
        );
      }
    } catch (e) {
      // Error handling
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving height: $e')),
      );
    }
  }

  // Function to navigate to the next page (Weight page)
  void _goToNextPage() {
    if (_heightController.text.isNotEmpty) {
      _saveHeight(); // Save the height before navigating
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Weight(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please enter your height'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: const Text(
                "How Tall are you?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            TextFormField(
              controller: _heightController,  // Assign the controller to the text field
              decoration: InputDecoration(labelText: "Enter height in cm"),
              keyboardType: TextInputType.number, // Ensuring the correct keyboard for number input
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _goToNextPage();  // Call function to navigate to next page and save height
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}


class Weight extends StatefulWidget {
  const Weight({super.key});

  @override
  State<Weight> createState() => _WeightState();
}

class _WeightState extends State<Weight> {
  final TextEditingController _weightController = TextEditingController(); // Controller for weight input
  final FirebaseAuth _auth = FirebaseAuth.instance; // Firebase Auth instance




  // Function to save the weight to Firestore
  Future<void> _saveWeight() async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        double? weight = double.tryParse(_weightController.text);
        // Save weight to Firestore under the user's UID
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'weight': weight  // Save the weight entered by the user
        }, SetOptions(merge: true));

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Weight ${_weightController.text} kg saved successfully!')),
        );
      } else {
        // Handle the case when no user is logged in
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: No user logged in')),
        );
      }
    } catch (e) {
      // Error handling
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving weight: $e')),
      );
    }
  }

  // Function to navigate to the next page (TargetWeight page)
  void _goToNextPage() {
    if (_weightController.text.isNotEmpty) {
      _saveWeight(); // Save the weight before navigating
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const TargetWeight(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please enter your weight'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: const Text(
                "What's your weight?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            TextFormField(
              controller: _weightController,  // Assign the controller to the text field
              decoration: InputDecoration(labelText: "Enter weight in Kg"),
              keyboardType: TextInputType.number,  // Ensuring the correct keyboard for number input
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _goToNextPage();// Call function to navigate to next page and save weight

              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}




class TargetWeight extends StatefulWidget {
  const TargetWeight({super.key});

  @override
  State<TargetWeight> createState() => _TargetWeightState();
}


class _TargetWeightState extends State<TargetWeight> {
  final TextEditingController _targetWeightController = TextEditingController(); // Controller for target weight input
  final FirebaseAuth _auth = FirebaseAuth.instance; // Firebase Auth instance
  int bmi = 0;  // Variable to store BMI

  // Function to save the target weight and BMI to Firestore
  Future<void> _saveTargetWeightAndBMI() async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        // Assuming the height and weight are already saved for the user
        DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        if (snapshot.exists) {
          // Extract the height and current weight from Firestore
          double heightStr = snapshot['height'];
          double currentWeightStr = snapshot['weight'];

          double height = heightStr / 100; // Convert height to meters
          double currentWeight = currentWeightStr;

          // Calculate BMI using current weight and height
          setState(() {
            bmi = (currentWeight / (height * height)).round();
          });

          // Save the target weight and BMI to Firestore under the user's UID
          await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
            'target_weight': _targetWeightController.text,
            'bmi': bmi.toString(),
          }, SetOptions(merge: true));

          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Target weight and BMI saved successfully!')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: User data not found')),
          );
        }
      } else {
        // Handle the case when no user is logged in
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: No user logged in')),
        );
      }
    } catch (e) {
      // Error handling
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving target weight and BMI: $e')),
      );
    }
  }

  // Function to navigate to the next page (or handle finalization)
  void _goToNextPage() {
    if (_targetWeightController.text.isNotEmpty) {
      _saveTargetWeightAndBMI();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Choice(),
        ),
      );// Save the target weight and BMI before proceeding
      // Add the next navigation step here, if any

    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please enter your target weight'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: const Text(
                "What's your target weight?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Text("Your BMI is: $bmi"),  // Display the calculated BMI
            TextFormField(
              controller: _targetWeightController,  // Assign the controller to the text field
              decoration: InputDecoration(labelText: "Enter target weight in Kg"),
              keyboardType: TextInputType.number,  // Ensuring the correct keyboard for number input
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _goToNextPage();// Call function to save data and navigate
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

class Choice extends StatefulWidget {
  const Choice({super.key});

  @override
  State<Choice> createState() => _ChoiceState();
}

class _ChoiceState extends State<Choice> {
  String? _selectedOption;


  int calculateCalories({
    required int age,
    required double weight,  // in kilograms
    required double height,  // in centimeters
    required String gender,  // 'male' or 'female'
    required String activity,  // sedentary, lightly active, etc.
    required String goal  // 'lose', 'gain', or 'maintain'
  }) {
    double bmr;

    // Calculate BMR using Mifflin-St Jeor Equation
    if (gender == 'male') {
      bmr = (10 * weight) + (6.25 * height) - (5 * age) + 5;
    } else {
      bmr = (10 * weight) + (6.25 * height) - (5 * age) - 161;
    }
    print(weight);
    print(height);
    print(age);
    print(bmr);


    // Adjust BMR based on activity level
    double activityMultiplier;
    switch (activity) {
      case 'Sedentary':
        activityMultiplier = 1.2;
        break;
      case 'Lightly active':
        activityMultiplier = 1.375;
        break;
      case 'Moderately active':
        activityMultiplier = 1.55;
        break;
      case 'Very active':
        activityMultiplier = 1.725;
        break;
      case 'Super active':
        activityMultiplier = 1.9;
        break;
      default:
        activityMultiplier = 1.2;
    }

    double tdee = bmr * activityMultiplier;
    print(tdee);
    // Adjust calories based on goal
    if (goal == 'lose') {
      return (tdee - 500).round();
    } else if (goal == 'gain') {
      return (tdee + 500).round();
    }
    else {
      return tdee.round();  // For maintenance
    }

  }

  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _activityController = TextEditingController();


  Future<void> _fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot snapshot =
      await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

        // Set the values to the controllers
        _ageController.text = data['age']?.toString() ?? '';
        _weightController.text = data['weight']?.toString() ?? '';
        _heightController.text = data['height']?.toString() ?? '';
        _genderController.text = data['gender'] ?? '';
        _activityController.text = data['activity'] ?? '';

      }
    }
  }
  @override
  void initState() {
    super.initState();
    _fetchUserData(); // Fetch user data when the widget initializes
  }



  Future<void> saveCaloriesToFirestore({
    required int age,
    required double weight,
    required double height,
    required String gender,
    required String activity,
    required String goal
  }) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      int requiredCalories = calculateCalories(
        age: age,
        weight: weight,
        height: height,
        gender: gender,
        activity: activity,
        goal: goal,
      );

      // Store the required calories in Firestore
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'calories': requiredCalories,
      }, SetOptions(merge: true));
      print(_ageController);
      print(_activityController);
      print(_weightController);

      print('Calories saved successfully!');
    } else {
      print('No user is signed in.');
    }
  }


  void _saveChoice() async {
    User? user = FirebaseAuth.instance.currentUser;
    print(_selectedOption);
    if (_selectedOption != null) {
      await FirebaseFirestore.instance.collection('users').doc(user?.uid).set({
        'goal': _selectedOption,
        'timestamp': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      // Optionally, show a confirmation message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Choice saved!')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            title: const Text('Weight gain'),
            leading: Radio<String>(
              value: 'gain',
              groupValue: _selectedOption,
              onChanged: (String? value) {
                setState(() {
                  _selectedOption = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Weight loss'),
            leading: Radio<String>(
              value: 'lose',
              groupValue: _selectedOption,
              onChanged: (String? value) {
                setState(() {
                  _selectedOption = value;
                });
              },
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              // Retrieve values from controllers
              int age = int.tryParse(_ageController.text) ?? 0; // Default to 0 if not a valid number
              double weight = double.tryParse(_weightController.text) ?? 0.0; // Default to 0.0
              double height = double.tryParse(_heightController.text) ?? 0.0; // Default to 0.0
              String gender = _genderController.text; // Get the gender as string
              String activity = _activityController.text; // Get the activity level as string

              _saveChoice();
              await saveCaloriesToFirestore(
                age: age,
                weight: weight,
                height: height,
                gender: gender,
                activity: activity,

                goal: _selectedOption ?? 'maintain', // use selected option
              );

              Navigator.push(context, MaterialPageRoute(builder: (context) => Option()));

            },
            child: Text('Save Choice'),
          ),
        ],
      ),
    );
  }
}




/*
Widget active(String title, String subtitle, String assetPath) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 7),
              color: Colors.green.shade900.withOpacity(.2),
              spreadRadius: 2,
              blurRadius: 10
          )
        ]
    ),
    child: ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14.0,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontStyle: FontStyle.italic,
          fontSize: 12.0,
        ),
      ),
      leading: CircleAvatar(
        radius: 30,
        child: ClipOval(
          child: Image.asset(
            assetPath,
            width: 100,
            height: 100,
            fit: BoxFit.contain,
          ),
        ),
      ),

      tileColor: Colors.white,
    ),
  );
}
*/