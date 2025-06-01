// lib/features/facade/presentation/facade_screen.dart

import 'package:flutter/material.dart';
import '../../../core/widgets/checklist_screen.dart';
import '../../core/models/rubrique.dart'; // Import the Rubrique model
import 'enseignes_lumineuses_screen.dart';

class FacadeScreen extends StatelessWidget {
  final Map<String, dynamic>? initialData;
  final Function(Map<String, dynamic>) onSaveData;
  final Rubrique rubrique; // ✅ Add the rubrique parameter

  const FacadeScreen({
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
      nextScreen: EnseignesLumineusesScreen(
        initialData: const {}, // Replace with actual data if needed
        onSaveData: (data) {
          // Handle saved data from EnseignesLumineusesScreen if needed
          print('Data from Enseignes Lumineuses: $data');
        },
        rubrique: rubrique, // ✅ Pass the rubrique here
      ),
    );
  }
}
