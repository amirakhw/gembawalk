// lib/features/femme_de_menage/presentation/femme_de_menage_screen.dart

import 'package:flutter/material.dart';
import '../../../core/widgets/checklist_screen.dart';
import '../../core/models/rubrique.dart';
import 'directeur_d_agence_screen.dart';

class FemmeDeMenageScreen extends StatelessWidget {
  final Map<String, dynamic>? initialData;
  final Function(Map<String, dynamic>) onSaveData;
  final Rubrique rubrique;

  const FemmeDeMenageScreen({
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
      initialData: initialData,
      onSaveData: (data) => Navigator.pop(context, data),
      nextScreen: DirecteurDAgenceScreen(
        initialData: const {},
        onSaveData: (data) {
          print('Data from Directeur d\'Agence: $data');
        },
        rubrique: rubrique,
      ),
    );
  }
}
