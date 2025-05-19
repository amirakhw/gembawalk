// lib/features/outils_et_session/presentation/outils_et_session_screen.dart

import 'package:flutter/material.dart';
import '../../../core/widgets/checklist_screen.dart';
import '../../core/models/rubrique.dart'; // Import the Rubrique model
import 'chambre_coffre_screen.dart'; // Import the next screen

class OutilsEtSessionScreen extends StatelessWidget {
  final Map<String, dynamic>? initialData;
  final Function(Map<String, dynamic>) onSaveData;
  final Rubrique rubrique; // ✅ Add the rubrique parameter

  const OutilsEtSessionScreen({
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
      nextScreen: ChambreCoffreScreen(
        initialData: const {}, // Adjust if you have initial data for this screen
        onSaveData: (data) {
          // Handle saved data from ChambreCoffreScreen
          print('Data from Chambre et Coffre fort: $data');
        },
        rubrique: rubrique, // ✅ Pass the rubrique here
      ),
    );
  }
}