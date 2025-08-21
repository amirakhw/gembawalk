// lib/features/bloc_sanitaire/presentation/bloc_sanitaire_screen.dart

import 'package:flutter/material.dart';
import '../../../core/widgets/checklist_screen.dart';
import '../../core/models/rubrique.dart';
import 'infrastructure_et_materiel_screen.dart';

class BlocSanitaireScreen extends StatelessWidget {
  final Map<String, dynamic>? initialData;
  final Function(Map<String, dynamic>) onSaveData;
  final Rubrique rubrique;

  const BlocSanitaireScreen({
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
      nextScreen: InfrastructureEtMaterielScreen(
        initialData: const {},
        onSaveData: (data) {
          print('Data from Infrastructure et Matériel: $data');
        },
        rubrique: rubrique,
      ),
    );
  }
}
