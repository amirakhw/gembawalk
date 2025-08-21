// lib/features/infrastructure_et_materiel/presentation/infrastructure_et_materiel_screen.dart

import 'package:flutter/material.dart';
import '../../../core/widgets/checklist_screen.dart';
import '../../core/models/rubrique.dart';
import 'environnement_screen.dart';

class InfrastructureEtMaterielScreen extends StatelessWidget {
  final Map<String, dynamic>? initialData;
  final Function(Map<String, dynamic>) onSaveData;
  final Rubrique rubrique;

  const InfrastructureEtMaterielScreen({
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
      nextScreen: EnvironnementScreen(
        initialData: const {},
        onSaveData: (data) {
          print('Data from Environnement: $data');
        },
        rubrique: rubrique,
      ),
    );
  }
}
