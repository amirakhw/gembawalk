// lib/features/gemba_walk/presentation/qualite_rubrique_screen.dart

import 'package:flutter/material.dart';
import '../../../core/widgets/questionnaire_screen.dart';
import '../../core/models/rubrique.dart';
import 'conseille_de_clientele_screen.dart';

class QualiteRubriqueScreen extends StatelessWidget {
  final Map<String, dynamic>? initialData;
  final Function(Map<String, dynamic>) onSaveData;
  final Rubrique rubrique;

  const QualiteRubriqueScreen({
    super.key,
    this.initialData,
    required this.onSaveData,
    required this.rubrique,
  });

  @override
  Widget build(BuildContext context) {
    return QuestionnaireScreen(
      title: rubrique.name,
      questions: rubrique.questions,
      initialData: initialData,
      onSaveData: onSaveData,
      nextScreen: ConseilleDeClienteleScreen(
        initialData: null,
        onSaveData: (data) {
          onSaveData(data);
        },
        rubrique: rubrique,
      ),
    );
  }
}
