// lib/features/directeur_d_agence/presentation/directeur_d_agence_screen.dart

import 'package:flutter/material.dart';
import '../../../core/widgets/checklist_screen.dart';
import '../../core/models/rubrique.dart';
import 'qualite_rubrique_screen.dart';

class DirecteurDAgenceScreen extends StatelessWidget {
  final Map<String, dynamic>? initialData;
  final Function(Map<String, dynamic>) onSaveData;
  final Rubrique rubrique;

  const DirecteurDAgenceScreen({
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
      nextScreen: QualiteRubriqueScreen(
        initialData: const {},
        onSaveData: (data) {
          print('Data from Qualité Rubrique: $data');
        },
        rubrique: rubrique,
      ),
    );
  }
}
