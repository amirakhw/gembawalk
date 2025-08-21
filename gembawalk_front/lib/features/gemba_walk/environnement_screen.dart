// lib/features/environnement/presentation/environnement_screen.dart

import 'package:flutter/material.dart';
import '../../../core/widgets/checklist_screen.dart';
import '../../core/models/rubrique.dart';
import 'extincteurs_screen.dart';

class EnvironnementScreen extends StatelessWidget {
  final Map<String, dynamic>? initialData;
  final Function(Map<String, dynamic>) onSaveData;
  final Rubrique rubrique;

  const EnvironnementScreen({
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
      nextScreen: ExtincteursScreen(
        initialData: const {},
        onSaveData: (data) {
          print('Data from Extincteurs: $data');
        },
        rubrique: rubrique,
      ),
    );
  }
}
