// lib/features/environnement/presentation/environnement_screen.dart

import 'package:flutter/material.dart';
import '../../../core/widgets/checklist_screen.dart';
import '../../core/models/rubrique.dart'; // Import the Rubrique model
import 'extincteurs_screen.dart'; // Import the next screen

class EnvironnementScreen extends StatelessWidget {
  final Map<String, dynamic>? initialData;
  final Function(Map<String, dynamic>) onSaveData;
  final Rubrique rubrique; // ✅ Add the rubrique parameter

  const EnvironnementScreen({
    super.key,
    this.initialData,
    required this.onSaveData,
    required this.rubrique, // ✅ Make it required
  });

  @override
  Widget build(BuildContext context) {
    return ChecklistScreen(
      rubrique: rubrique, // ✅ Pass the rubrique
      title: rubrique.name, // Use the rubrique's name
      //items: rubrique.checklistItems.map((item) => item.name).toList(), // Use the rubrique's items
      initialData: initialData,
      onSaveData: (data) => Navigator.pop(context, data),
      nextScreen: ExtincteursScreen(
        initialData: const {}, // Adjust if you have initial data for this screen
        onSaveData: (data) {
          // Handle saved data from ExtincteursScreen
          print('Data from Extincteurs: $data');
        },
        rubrique: rubrique, // ✅ Pass the rubrique here
      ),
    );
  }
}