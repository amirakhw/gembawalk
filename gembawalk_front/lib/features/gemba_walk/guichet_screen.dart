// lib/features/guichet/presentation/guichet_screen.dart

import 'package:flutter/material.dart';
import '../../../core/widgets/checklist_screen.dart';
import '../../core/models/rubrique.dart';
import 'outils_et_session_screen.dart';

class GuichetScreen extends StatelessWidget {
  final Map<String, dynamic>? initialData;
  final Function(Map<String, dynamic>) onSaveData;
  final Rubrique rubrique;

  const GuichetScreen({
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
      nextScreen: OutilsEtSessionScreen(
        initialData: const {},
        onSaveData: (data) {
          print('Data from Outils et Session: $data');
        },
        rubrique: rubrique,
      ),
    );
  }
}
