import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gembawalk_front/NotifierProviders/all_data.dart';
import 'package:gembawalk_front/config/theme.dart';
import 'package:gembawalk_front/core/models/form.dart';
import 'package:gembawalk_front/core/models/rubrique.dart';
import 'package:gembawalk_front/core/service/form_api_service.dart';
import 'package:provider/provider.dart';
import '../../../core/widgets/checklist_screen.dart';
import '../../core/models/checklist_item.dart';
import '../../core/models/question.dart';
import '../../core/widgets/questionnaire_screen.dart';
import 'qualite_rubrique_screen.dart';
import 'package:gembawalk_front/config/colors.dart';

class GembaWalkMenuScreen extends StatefulWidget {
  final int regionId;
  final int formId;
  final int groupId;
  final int agenceId;

  //is this used anywhere? --wael
  final Map<String, dynamic>? previousData;

  const GembaWalkMenuScreen({
    super.key,
    required this.formId,
    required this.regionId,
    required this.groupId,
    this.previousData,
    required this.agenceId,
  });

  @override
  State<GembaWalkMenuScreen> createState() => _GembaWalkMenuScreenState();
}

class _GembaWalkMenuScreenState extends State<GembaWalkMenuScreen> {
  late Future<FormModel> _formFuture;
  late FormApiService _formService;
  Map<int, Map<String, dynamic>> allData = {};
  Map<int, bool> rubriqueCompletionStatus = {}; // <rubriqueId, isCompleted>
  bool _isFormCompleted = false;

  @override
  void initState() {
    super.initState();
    _formService = FormApiService(
      baseUrl: 'http://' + dotenv.get('LOCALIP') + ':8080/api',
    );
    _formFuture = _formService.fetchForm(widget.formId);
  }

  void updateRubriqueData(
    Map<String, dynamic> newData,
    int rubriqueId,
    bool isCompleted,
  ) {
    print(
      "******************************************updating rubrique checklist answers***************",
    );
    setState(() {
      allData[rubriqueId] = newData;
      rubriqueCompletionStatus[rubriqueId] = isCompleted;
    });
  }

  void _submitForm() {
    context.read<LocalDB>().add(allData, widget.agenceId);

    setState(() {
      allData = {};
      rubriqueCompletionStatus = {};
    });
  }

  void navigateToRubrique(Rubrique rubrique) {
    Widget nextScreen;
    Function(Map<String, dynamic>) onSave;

    switch (rubrique.type) {
      case 'CHECKLIST':
        onSave = (newData) {
          updateRubriqueData(
            newData,
            rubrique.id!,
            _isChecklistCompleted(
              newData,
              rubrique.checklistItems,
            ), // Use checklistItems
          );
        };
        nextScreen = ChecklistScreen(
          rubrique: rubrique,
          initialData: allData[rubrique.id],
          onSaveData: onSave,
          title: rubrique.name,
          //items: rubrique.checklistItems.map((item) => item.name).toList(), // Extract names from ChecklistItems
        );
        break;
      case 'QUESTIONS':
        onSave = (newData) {
          updateRubriqueData(
            newData,
            rubrique.id!,
            _areAllQuestionsAnswered(
              newData,
              rubrique.questions,
            ), // Use questions
          );
        };
        nextScreen = QuestionnaireScreen(
          title: rubrique.name,
          questions: rubrique.questions,

          //rubrique: rubrique,
          //initialData: allData,
          onSaveData: onSave,
        );

        break;
      default:
        return;
    }

    Navigator.push(context, MaterialPageRoute(builder: (_) => nextScreen));
  }

  // Placeholder for checklist completion logic
  bool _isChecklistCompleted(
    Map<String, dynamic> responses,
    List<ChecklistItem> items,
  ) {
    // Implement your logic to check if all required checklist items are completed
    // based on the 'responses' and 'items'
    return false; // Replace with actual logic
  }

  // Placeholder for questions answered logic
  bool _areAllQuestionsAnswered(
    Map<String, dynamic> responses,
    List<Question> questions,
  ) {
    // Implement your logic to check if all required questions are answered
    // based on the 'responses' and 'questions'
    return false; // Replace with actual logic
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Gemba Walk'),
          backgroundColor: AppColors.primary,
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder<FormModel>(
                future: _formFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Erreur : ${snapshot.error}'));
                  }

                  final form = snapshot.data!;
                  final rubriques = form.rubriques;

                  return ListView.builder(
                    itemCount: rubriques.length,
                    itemBuilder: (context, index) {
                      final rubrique = rubriques[index];
                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          title: Text(rubrique.name),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () => navigateToRubrique(rubrique),
                        ),
                      );
                    },
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
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                  ),
                  child: const Text(
                    'Soumettre',
                    style: TextStyle(color: AppColors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
