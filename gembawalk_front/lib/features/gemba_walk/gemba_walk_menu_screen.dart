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

      print(allData);
    });
  }

  void _submitForm() async {
    if (_isFormCompleted) {
      final confirmPopUP = await showConfirmationDialog(
        context,
        content: 'Êtes-vous sûr de vouloir clôturer ce plan d\'action ?',
      );

      if (confirmPopUP) {
        context.read<LocalDB>().add(allData, widget.agenceId);

        setState(() {
          allData = {};
          rubriqueCompletionStatus = {};
          _isFormCompleted = false;
        });
      }
    } else {
      await showConfirmationDialog(
        context,
        content: 'kamel confirmi el items 9bal clôturer ce plan d\'action',
        confirmText: "behi",
        cancelText: "sama7ni",
      );
    }
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
              rubrique.id!,
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
          initialData: allData[rubrique.id],
          //rubrique: rubrique,
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
    int id,
  ) {
    for (var item in items) {
      if (responses["conformity"] == null ||
          !responses["conformity"].containsKey("item_${item.id}") ||
          responses["conformity"]["item_${item.id}"] == null) {
        print(
          "-----------------------  chacking rubrique completion ---------------------",
        );
        print(responses);
        return false;
      }
    }
    return true; // Replace with actual logic
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

  Future<bool> showConfirmationDialog(
    BuildContext context, {
    String title = 'Confirmation',
    String content = 'Êtes-vous sûr de vouloir marquer comme confirmé ?',
    String confirmText = 'Oui',
    String cancelText = 'Non',
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(cancelText),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text(confirmText),
              ),
            ],
          ),
    );

    return result ?? false; // false if dialog is dismissed
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Gemba Walk'),
          backgroundColor: AppColors.primary,
          elevation: 4,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder<FormModel>(
                  future: _formFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Erreur : ${snapshot.error}',
                          style: attijariTheme.textTheme.bodyMedium?.copyWith(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }

                    final form = snapshot.data!;
                    final rubriques = form.rubriques;

                    if (rubriques.isEmpty) {
                      return Center(
                        child: Text(
                          'Aucune rubrique disponible.',
                          style: attijariTheme.textTheme.bodyMedium,
                        ),
                      );
                    }

                    _isFormCompleted = rubriques.every(
                      (r) =>
                          r.id == 6 || rubriqueCompletionStatus[r.id] == true,
                    );
                    print(rubriqueCompletionStatus);
                    print(
                      "**************is walk completed check : ${_isFormCompleted}------------------",
                    );

                    return ListView.separated(
                      itemCount: rubriques.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final rubrique = rubriques[index];
                        return Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          shadowColor: Colors.black.withOpacity(0.1),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            title: Text(
                              rubrique.name,
                              style: attijariTheme.textTheme.titleMedium,
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.primary,
                              size: 18,
                            ),
                            onTap: () => navigateToRubrique(rubrique),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            tileColor:
                                (rubriqueCompletionStatus[rubrique.id!] ??
                                        false)
                                    ? AppColors.attijariSuccess
                                    : Colors.white,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 16,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      textStyle: attijariTheme.textTheme.titleMedium?.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text('Soumettre'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
