import 'package:calculator/Calculator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark, // Keeping the dark theme
        primaryColor: Colors.blue,   // Add a primary color for your app
        accentColor: Colors.amber,   // You can add an accent color for buttons or highlights
      ),
      home: const Calculator(), // Changed `calculator` to `Calculator` (PascalCase)
    );
  }
}
