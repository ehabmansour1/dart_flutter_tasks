import 'package:flutter/material.dart';
import 'screens/task1.dart';
import 'screens/task2.dart';
import 'widgets/toggle_switch.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showTask1 = true;

  void toggleTask(bool value) {
    setState(() {
      showTask1 = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Switcher"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: ToggleSwitch(isTask1: showTask1, onToggle: toggleTask),
          ),
        ],
      ),
      body: showTask1 ? Task1Screen() : Task2Screen(),
    );
  }
}
