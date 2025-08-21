// lib/features/chambre_gab/presentation/chambre_gab_screen.dart

import 'package:flutter/material.dart';
import '../../../core/widgets/checklist_screen.dart';
import '../../core/models/rubrique.dart';
import 'bloc_sanitaire_screen.dart';

class ChambreGabScreen extends StatelessWidget {
  final Map<String, dynamic>? initialData;
  final Function(Map<String, dynamic>) onSaveData;
  final Rubrique rubrique;

  const ChambreGabScreen({
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
      nextScreen: BlocSanitaireScreen(
        initialData: const {},
        onSaveData: (data) {
          print('Data from Bloc Sanitaire: $data');
        },
        rubrique: rubrique,
      ),
    );
  }
}
