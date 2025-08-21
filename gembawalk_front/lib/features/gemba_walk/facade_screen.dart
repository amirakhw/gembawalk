// lib/features/facade/presentation/facade_screen.dart

import 'package:flutter/material.dart';
import '../../../core/widgets/checklist_screen.dart';
import '../../core/models/rubrique.dart';
import 'enseignes_lumineuses_screen.dart';

class FacadeScreen extends StatelessWidget {
  final Map<String, dynamic>? initialData;
  final Function(Map<String, dynamic>) onSaveData;
  final Rubrique rubrique;

  const FacadeScreen({
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
      //items: rubrique.checklistItems.map((item) => item.name).toList(), // Use the rubrique's items
      initialData: initialData,
      onSaveData: (data) => Navigator.pop(context, data),
      nextScreen: EnseignesLumineusesScreen(
        initialData: const {},
        onSaveData: (data) {
          print('Data from Enseignes Lumineuses: $data');
        },
        rubrique: rubrique,
      ),
    );
  }
}
