// lib/features/outils_et_session/presentation/outils_et_session_screen.dart

import 'package:flutter/material.dart';
import '../../../core/widgets/checklist_screen.dart';
import '../../core/models/rubrique.dart';
import 'chambre_coffre_screen.dart';

class OutilsEtSessionScreen extends StatelessWidget {
  final Map<String, dynamic>? initialData;
  final Function(Map<String, dynamic>) onSaveData;
  final Rubrique rubrique;

  const OutilsEtSessionScreen({
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
      nextScreen: ChambreCoffreScreen(
        initialData: const {},
        onSaveData: (data) {
          print('Data from Chambre et Coffre fort: $data');
        },
        rubrique: rubrique,
      ),
    );
  }
}
