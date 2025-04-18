import 'package:flutter/material.dart';
import 'login_screen.dart'; // Import your theme if needed

class EnseignesLumineusesScreen extends StatefulWidget {
  const EnseignesLumineusesScreen({super.key});

  @override
  State<EnseignesLumineusesScreen> createState() => _EnseignesLumineusesScreenState();
}

class _EnseignesLumineusesScreenState extends State<EnseignesLumineusesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: attijariPrimary, // Use your theme color
        title: const Text('Enseignes lumineuses', style: TextStyle(color: attijariWhite, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: attijariWhite),
      ),
      body: const Center(
        child: Text('Coming Soon - Enseignes lumineuses checklist'),
      ),
    );
  }
}
