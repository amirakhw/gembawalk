// lib/features/conseille_de_clientele/presentation/conseille_de_clientele_screen.dart

import 'package:flutter/material.dart';
import '../../../core/widgets/checklist_screen.dart';
import '../../core/models/rubrique.dart';
import 'gestionnaire_de_clientele_principal_screen.dart';

class ConseilleDeClienteleScreen extends StatelessWidget {
  final Map<String, dynamic>? initialData;
  final Function(Map<String, dynamic>) onSaveData;
  final Rubrique rubrique;

  const ConseilleDeClienteleScreen({
    super.key,
    this.initialData,
    required this.onSaveData,
    required this.rubrique,
  });

  @override
  Widget build(BuildContext context) {
    return ChecklistScreen(
      rubrique: rubrique,
      title: rubrique.name,
      //items: rubrique.checklistItems.map((item) => item.name).toList(),
      initialData: initialData,
      onSaveData: (data) => Navigator.pop(context, data),
      nextScreen: GestionnaireClienteleScreen(
        initialData: const {}, // Adjust if you have initial data for this screen
        onSaveData: (data) {
          // Handle saved data from GestionnaireClienteleScreen
          print('Data from Gestionnaire de Clientèle Principal: $data');
        },
        rubrique: rubrique, // ✅ Pass the rubrique here
      ),
    );
  }
}