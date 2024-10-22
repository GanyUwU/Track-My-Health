
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_try/form.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pedometer/pedometer.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../nutrition/add_meal_screen.dart';
import '../nutrition/calories_stats_screen.dart';
import '../widgets/indicator_widget.dart';




class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime date = DateTime.now();




/*
  // ? steps vars
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?';
  int _todaySteps = 0;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void onStepCount(StepCount event) {
    log(event.toString());
    // DateTime s = event.timeStamp;
    setState(() {
      _todaySteps = event.steps;
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    log(event.toString());
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    log('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    log(_status);
  }

  void onStepCountError(error) {
    log('onStepCountError: $error');
    setState(() {
      // _todaySteps = 'Step Count not available';
    });
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TRACK YOUR CALORIES"),
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
/*
                  ElevatedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Choice()));
                      User? user = FirebaseAuth.instance.currentUser;
                      if (user != null) {
                        print('User is signed in: ${user.email}');
                        print('Display Name: ${user.displayName}');
                      } else {
                        print('No user is signed in');
                      }

                  },
                      child: Text("check")
                  ),

*/

                  SizedBox(height: 20,),

                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CaloriesStatsScreen(date: date),
                            ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: StreamBuilder<Object>(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .doc(FirebaseAuth
                                .instance.currentUser!.uid)
                                .collection('diary')
                                .doc(DateFormat('d-M-y')
                                .format(date))
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const MyCircularIndicator();
                              } else {
                                late num calories = 0.0,
                                    protein = 0.0,
                                    carbs = 0.0,
                                    fat = 0.0;
                                if (snapshot.data!.exists) {
                                  if (snapshot.data!
                                      .data()!
                                      .containsKey(
                                      'totalCalories')) {
                                    calories = snapshot.data!
                                        .get('totalCalories');
                                  }
                                  if (snapshot.data!
                                      .data()!
                                      .containsKey(
                                      'totalProtein')) {
                                    protein = snapshot.data!
                                        .get('totalProtein');
                                  }
                                  if (snapshot.data!
                                      .data()!
                                      .containsKey('totalFat')) {
                                    fat = snapshot.data!
                                        .get('totalFat');
                                  }
                                  if (snapshot.data!
                                      .data()!
                                      .containsKey(
                                      'totalCarbs')) {
                                    carbs = snapshot.data!
                                        .get('totalCarbs');
                                  }
                                }
                                return Column(
                                  children: [
                                    const Row(
                                      children: [
                                        Expanded(
                                            child: Text(
                                                'Calories',
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight
                                                        .bold,
                                                    fontSize:
                                                    20))),
                                        Align(
                                          alignment: Alignment
                                              .centerRight,
                                          child: Icon(
                                            Icons
                                                .local_fire_department,
                                            color: Color.fromARGB(
                                                255,
                                                248,
                                                105,
                                                51),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    SizedBox(
                                      height: 100,
                                      width: 150,
                                      child:
                                      CircularPercentIndicator(
                                        reverse: true,
                                        radius: 45,
                                        lineWidth: 7,
                                        animation: true,
                                        percent: calories < 2100
                                            ? calories / 2100
                                            : 1,
                                        center: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .center,
                                          children: [
                                            Text(
                                              calories.toString(),
                                              style: const TextStyle(
                                                  fontWeight:
                                                  FontWeight
                                                      .bold,
                                                  fontSize: 22),
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Text('Kcal',
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight
                                                        .bold,
                                                    fontSize: 12,
                                                    color: Colors
                                                        .grey
                                                        .shade500)),
                                          ],
                                        ),
                                        backgroundColor: Colors
                                            .grey.shade800
                                            .withOpacity(0.3),
                                        linearGradient:
                                        const LinearGradient(
                                            colors: [
                                              Color.fromARGB(255,
                                                  255, 209, 59),
                                              Color.fromARGB(255,
                                                  248, 105, 51),
                                            ],
                                            begin: Alignment
                                                .topLeft,
                                            end: Alignment
                                                .bottomLeft),
                                        circularStrokeCap:
                                        CircularStrokeCap
                                            .round,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceEvenly,
                                      children: [
                                        Column(
                                          children: [
                                            const Icon(
                                                FontAwesomeIcons
                                                    .bowlRice,
                                                color: Color
                                                    .fromARGB(
                                                    255,
                                                    250,
                                                    109,
                                                    77),
                                                size: 16),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            const Text('Carbs'),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  carbs
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                      FontWeight
                                                          .bold,
                                                      fontSize:
                                                      11),
                                                ),
                                                const Text(
                                                  'g',
                                                  style: TextStyle(
                                                      color: Colors
                                                          .grey,
                                                      fontSize:
                                                      10),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            const Icon(FontAwesomeIcons.cheese,
                                                color: Color
                                                    .fromARGB(
                                                    255,
                                                    151,
                                                    161,
                                                    255),
                                                size: 16),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            const Text('Fat'),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  fat.toString(),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                      FontWeight
                                                          .bold,
                                                      fontSize:
                                                      11),
                                                ),
                                                const Text(
                                                  'g',
                                                  style: TextStyle(
                                                      color: Colors
                                                          .grey,
                                                      fontSize:
                                                      10),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            const Icon(
                                                FontAwesomeIcons
                                                    .fish,
                                                color: Color
                                                    .fromARGB(
                                                    255,
                                                    247,
                                                    105,
                                                    132),
                                                size: 16),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            const Text('Protein'),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  protein
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                      FontWeight
                                                          .bold,
                                                      fontSize:
                                                      11),
                                                ),
                                                const Text(
                                                  'g',
                                                  style: TextStyle(
                                                      color: Colors
                                                          .grey,
                                                      fontSize:
                                                      10),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              }
                            }),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FabCircularMenu(
        onDisplayChange: (isOpen) {
          BackdropFilter(filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10));
        },
        ringColor: Theme
            .of(context)
            .scaffoldBackgroundColor,
        fabOpenIcon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        fabCloseIcon: const Icon(
          Icons.close,
          color: Colors.white,
        ),
        ringWidth: 130,
        fabCloseColor: Colors.red,
        fabOpenColor: Colors.grey.shade800,
        children: [
          RawMaterialButton(onPressed: () {}),
          RawMaterialButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return SimpleDialog(
                        title: const Text('Meals'),
                        children: [
                          SimpleDialogOption(
                              child: const Text('Breakfast'),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const AddMealScreen(
                                          title: 'Breakfast',
                                        )));
                              }),
                          SimpleDialogOption(
                              child: const Text('Lunch'),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const AddMealScreen(
                                            title: 'Lunch')));
                              }),
                          SimpleDialogOption(
                              child: const Text('Dinner'),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const AddMealScreen(
                                            title: 'Dinner')));
                              }),
                          SimpleDialogOption(
                              child: const Text('Snacks'),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const AddMealScreen(
                                            title: 'Snacks')));
                              }),
                        ],
                      );
                    });
                // TODO: add food
              },
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              fillColor: Colors.blue,
              child: const Icon(
                Icons.restaurant,
              )
          ),
          RawMaterialButton(
            onPressed: () {},
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(24.0),
            fillColor: Colors.blue,
            child: const Icon(
              Icons.fitness_center,
            ),
          ),
        ],
      ),
    );
  }
}
