// lib/features/agent_de_securite/presentation/agent_de_securite_screen.dart

import 'package:flutter/material.dart';
import '../../../core/widgets/checklist_screen.dart';
import '../../core/models/rubrique.dart';
import 'femme_de_menage_screen.dart';

class AgentDeSecuriteScreen extends StatelessWidget {
  final Map<String, dynamic>? initialData;
  final Function(Map<String, dynamic>) onSaveData;
  final Rubrique rubrique;

  const AgentDeSecuriteScreen({
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
      nextScreen: FemmeDeMenageScreen(
        initialData: const {},
        onSaveData: (data) {
          print('Data from Femme de Ménage: $data');
        },
        rubrique: rubrique,
      ),
    );
  }
}
