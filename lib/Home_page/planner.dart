
import 'dart:async';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sensors_plus/sensors_plus.dart';

class StepCount extends StatefulWidget {
  const StepCount({super.key});

  @override
  State<StepCount> createState() => _StepCountState();
}


class _StepCountState extends State<StepCount> {
  DateTime date = DateTime.now();



  int _steps = 0;
  List<double> _accelerometerValues = [0, 0, 0];
  double _lastMagnitude = 0;
  int _targetSteps = 100; // Default target steps
  final TextEditingController _controller = TextEditingController();
  bool _dialogShown = false;
  StreamSubscription<AccelerometerEvent>? _accelerometerSubscription;


  @override
  void initState() {
    super.initState();
    startListening();
  }
  @override
  void dispose() {
    _accelerometerSubscription?.cancel();  // Safely cancel the subscription
    super.dispose();
  }


  // Start listening to accelerometer events
  void startListening() {
    _accelerometerSubscription = accelerometerEvents.listen((AccelerometerEvent event) {

      setState(() {
        _accelerometerValues = [event.x, event.y, event.z];

        // Check for step detection
        if (isStepDetected(event)) {
          _steps++;
          //_animationController.forward(from: 0); // Start the animation
          print('Step detected! Total steps: $_steps'); // Debugging log

          // Check if target is reached and dialog is not already shown
          if (_steps >= _targetSteps && !_dialogShown) {
            _showTargetHitDialog(); // Show dialog when target is hit
            _dialogShown = true; // Mark dialog as shown
            print("Target reached: $_steps steps"); // Debugging log
          }
        }
      });

    });
  }
  // Function to detect steps based on accelerometer data
  bool isStepDetected(AccelerometerEvent event) {
    double magnitude = sqrt(event.x * event.x + event.y * event.y + event.z * event.z);

    // Simple threshold-based detection
    if (magnitude > 15 && _lastMagnitude <= 15) {
      _lastMagnitude = magnitude;
      return true;
    } else {
      _lastMagnitude = magnitude;
      return false;
    }
  }
  // Function to update target steps
  void _setTargetSteps() {
    int? newTarget = int.tryParse(_controller.text);
    if (newTarget != null && newTarget > 0) {
      setState(() {
        _targetSteps = newTarget;
        _steps = 0; // Reset steps when target is changed
        _dialogShown = false; // Reset dialog shown state
      });
      _controller.clear(); // Clear input field
      print("Target steps set to: $_targetSteps"); // Debugging log
    } else {
      print("Invalid target steps input."); // Debugging log
    }
  }

  // Function to show target hit dialog
  void _showTargetHitDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Congratulations!"),
          content: Text("You've reached your target of $_targetSteps steps!"),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TRACK YOUR STEPS"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () async {
            await FirebaseAuth.instance.signOut();
          },
            icon: Icon(Icons.login),
          )
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        DateTime
                            .now()
                            .hour > 12 || DateTime
                            .now()
                            .hour < 3
                            ? 'Good evening, '
                            : 'Good morning, ',
                        style: const TextStyle(fontSize: 22),
                      ),
                      Text(
                        FirebaseAuth.instance.currentUser?.displayName ??
                            'Guest',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () async {
                        DateTime? newDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now());

                        if (newDate == null) return;

                        setState(() {
                          date = newDate;
                        });
                      },
                      child: Text(
                        DateFormat('d MMMM, y').format(date),
                        style:
                        const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),


                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            const Row(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Text('Activity',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Today',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: CircularPercentIndicator(
                                    // reverse: true,
                                    radius: 50,
                                    lineWidth: 7,
                                    animation: true,
                                    animateFromLastPercent: true,
                                    percent: _steps < 12000
                                        ? _steps / 12000
                                        : 1,
                                    center: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '$_steps',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22),
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text('Steps',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color:
                                                Colors.grey.shade500)),
                                      ],
                                    ),
                                    backgroundColor: Colors.grey.shade800
                                        .withOpacity(0.3),
                                    linearGradient:
                                    const LinearGradient(colors: [
                                      Color.fromARGB(255, 224, 139, 27),
                                      Colors.pink,
                                    ]),
                                    circularStrokeCap:
                                    CircularStrokeCap.round,
                                  ),
                                ),
                                Expanded(
                                  child: CircularPercentIndicator(
                                    // reverse: true,
                                    radius: 50,
                                    lineWidth: 7,
                                    animation: true,
                                    percent: _steps * 0.04 / 1000,
                                    center: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          (_steps * 0.04)
                                              .round()
                                              .toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22),
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                                Icons.local_fire_department,
                                                size: 12),
                                            Text('kcal',
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    fontSize: 12,
                                                    color: Colors
                                                        .grey.shade500)),
                                          ],
                                        ),
                                      ],
                                    ),
                                    backgroundColor: Colors.grey.shade800
                                        .withOpacity(0.3),
                                    linearGradient: const LinearGradient(
                                        colors: [
                                          Color.fromARGB(255, 224, 139, 27),
                                          Colors.pink
                                        ]),
                                    circularStrokeCap:
                                    CircularStrokeCap.round,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    const Icon(Icons.location_on,
                                        color: Color.fromARGB(
                                            255, 255, 150, 128)),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    const Text('Distance'),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          (_steps * 0.0007)
                                              .toStringAsFixed(2),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Text(
                                          'km',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 10),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                const Column(
                                  children: [
                                    Icon(
                                        FontAwesomeIcons.personWalking,
                                        color: Color.fromARGB(
                                            255, 249, 149, 76)),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text('Walking'),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '76',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '%',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                const Column(
                                  children: [
                                    Icon(
                                        FontAwesomeIcons.personRunning,
                                        color: Color.fromARGB(
                                            255, 247, 105, 132)),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text('Running'),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '24',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '%',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20,),

                ],
              ),
            ),
          )
        ],
      ),

    );
  }
}
