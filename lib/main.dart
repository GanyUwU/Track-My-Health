
import 'package:firebase_core/firebase_core.dart';
import 'package:fit_try/Home_page/profile_screen.dart';
import 'package:fit_try/auth/auth.dart';
import 'package:fit_try/recipe_screen/recipe_screen.dart';
import 'package:flutter/material.dart';
import 'Home_page/buying.dart';
import 'Home_page/home.dart';
import 'Home_page/planner.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MaterialApp(
    home: Auth(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  final tabs = [
    const Home(),
    StepCount(),
    Buying(),
    RecipesScreen(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        fixedColor: Colors.green.shade900,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.track_changes),
            label: "Steps",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_rounded),
            label: "Buy",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            label: "Recipes",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}




