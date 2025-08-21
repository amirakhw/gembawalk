// lib/features/gestionnaire_clientele/presentation/gestionnaire_clientele_screen.dart

import 'package:flutter/material.dart';
import '../../../core/widgets/checklist_screen.dart';
import '../../core/models/rubrique.dart';
import 'guichet_screen.dart';

class GestionnaireClienteleScreen extends StatelessWidget {
  final Map<String, dynamic>? initialData;
  final Function(Map<String, dynamic>) onSaveData;
  final Rubrique rubrique;

  const GestionnaireClienteleScreen({
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
      nextScreen: GuichetScreen(
        initialData: const {},
        onSaveData: (data) {
          print('Data from Guichet: $data');
        },
        rubrique: rubrique,
      ),
    );
  }
}
