// lib/features/enseignes_lumineuses/presentation/enseignes_lumineuses_screen.dart

import 'package:flutter/material.dart';
import '../../../core/widgets/checklist_screen.dart';
import '../../core/models/rubrique.dart';
import 'agent_de_securite_screen.dart';

class EnseignesLumineusesScreen extends StatelessWidget {
  final Map<String, dynamic>? initialData;
  final Function(Map<String, dynamic>) onSaveData;
  final Rubrique rubrique;

  const EnseignesLumineusesScreen({
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
      nextScreen: AgentDeSecuriteScreen(
        initialData: const {},
        onSaveData: (data) {
          print('Data from Agent de Sécurité: $data');
        },
        rubrique: rubrique,
      ),
    );
  }
}
