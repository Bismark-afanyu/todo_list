import 'package:flutter/material.dart';
import 'package:todo/constanst/colors.dart';
import 'package:todo/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: tdbrown),
          useMaterial3: true,
        ),
        home: const HomeScreen());
  }
}
