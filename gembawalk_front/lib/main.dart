
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gemba Walk',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFFDF7F0),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFFFF6600),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}