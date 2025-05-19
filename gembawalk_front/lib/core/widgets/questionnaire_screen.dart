// lib/core/widgets/questionnaire_screen.dart

import 'package:flutter/material.dart';
import 'package:gembawalk_front/config/colors.dart';
import '../../core/models/question.dart'; // Import the Question model

class QuestionnaireScreen extends StatefulWidget {
  final String title;
  final List<Question> questions; // ✅ Change to List<Question>
  final Map<String, dynamic>? initialData;
  final Function(Map<String, dynamic>) onSaveData;
  final Widget? nextScreen;

  const QuestionnaireScreen({
    super.key,
    required this.title,
    required this.questions, // ✅ Update required parameter type
    this.initialData,
    required this.onSaveData,
    this.nextScreen,
  });

  @override
  _QuestionnaireScreenState createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  late Map<int, TextEditingController> _controllers; // Use int as key for question ID

  @override
  void initState() {
    super.initState();
    print("********************init questionnaireScreen*****************************");
    _controllers = {
      for (var q in widget.questions) // Iterate over Question objects
        q.id: TextEditingController(text: widget.initialData?['question_${q.id}'] ?? ''), // Use question ID as key
    };

    // 👉 Auto‑save on every change:
    for (var ctrl in _controllers.values) {
      ctrl.addListener(_autoSave);
    }
  }

  @override
  void dispose() {
    for (var ctrl in _controllers.values) {
      ctrl.removeListener(_autoSave);
      ctrl.dispose();
    }
    super.dispose();
  }

  void _autoSave() {
    widget.onSaveData(_collectResponses());
  }

  Map<String, dynamic> _collectResponses() {
    return {
      for (var entry in _controllers.entries) 'question_${entry.key}': entry.value.text, // Use 'question_' prefix for keys
    };
  }

  void _returnToMenu() {
    // final safety save (in case anything is still pending)
    widget.onSaveData(_collectResponses());
    Navigator.pop(context);
  }

  void _goNext() {
    widget.onSaveData(_collectResponses());
    if (widget.nextScreen != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => widget.nextScreen!),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          title: Text(widget.title,
              style: const TextStyle(color: AppColors.white)),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: widget.questions.length,
                itemBuilder: (ctx, i) {
                  final q = widget.questions[i];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(q.questionText, // Use questionText from the Question object
                            style: const TextStyle(
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _controllers[q.id], // Use question ID as key
                          maxLines: null,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Votre réponse',
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom + 16,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _returnToMenu,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.primary),
                        foregroundColor: AppColors.primary,
                      ),
                      child: const Text('Retourner au Menu'),
                    ),
                  ),
                  if (widget.nextScreen != null) ...[
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _goNext,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                        ),
                        child: const Text('Suivant',
                            style: TextStyle(color: AppColors.white)),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}