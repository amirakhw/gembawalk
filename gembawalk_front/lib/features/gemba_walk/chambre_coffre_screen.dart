// lib/features/chambre_coffre/presentation/chambre_coffre_screen.dart

import 'package:flutter/material.dart';
import '../../../core/widgets/checklist_screen.dart';
import '../../core/models/rubrique.dart';
import 'chambre_gab_screen.dart';

class ChambreCoffreScreen extends StatelessWidget {
  final Map<String, dynamic>? initialData;
  final Function(Map<String, dynamic>) onSaveData;
  final Rubrique rubrique;

  const ChambreCoffreScreen({
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
      nextScreen: ChambreGabScreen(
        initialData: const {},
        onSaveData: (data) {
          print('Data from Chambre GAB: $data');
        },
        rubrique: rubrique,
      ),
    );
  }
}
