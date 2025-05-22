import 'package:flutter/material.dart';
import 'package:gembawalk_front/config/theme.dart';
import 'package:gembawalk_front/config/colors.dart';
import 'package:gembawalk_front/core/models/checklist_item_reponse.dart';
import 'package:gembawalk_front/core/models/planAction.dart';
import 'package:gembawalk_front/core/service/planAction_api_service.dart';

class PlanDActionScreen extends StatefulWidget {
  final PlanActionModel visit;

  const PlanDActionScreen({super.key, required this.visit});

  @override
  State<PlanDActionScreen> createState() => _PlanDActionScreenState();
}

class _PlanDActionScreenState extends State<PlanDActionScreen> {
  late final PlanactionApiService planactionApiService;
  late Future<List<ChecklistItemReponseModel>> actionItems;

  @override
  void initState() {
    super.initState();
    planactionApiService = PlanactionApiService();
    actionItems = planactionApiService
        .fetchChecklistRepoonse(widget.visit.id)
        .then(
          (list) => list.where((item) => item.status == 'NON_CONFORM').toList(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: attijariPrimary,
        title: Text(
          'Plan d\'Action - Agence ${widget.visit.id}',
          style: const TextStyle(
            color: attijariWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: attijariWhite),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Table Header
            Row(
              children: const [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Item',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: attijariTextPrimary,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Numéro de ticket',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: attijariTextPrimary,
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'État',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: attijariTextPrimary,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'Confirmé par visiteur',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: attijariTextPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(),
            // Table Rows
            FutureBuilder<List<ChecklistItemReponseModel>>(
              future: actionItems, // Replace with your actual async method
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('No action items available.'),
                  );
                }

                final _actionItems = snapshot.data!;

                return Expanded(
                  child: ListView.builder(
                    itemCount: _actionItems.length,
                    itemBuilder: (context, index) {
                      final item = _actionItems[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                "${item.rubrique_name} . ${item.item_name}",
                              ),
                            ),
                            Expanded(child: Text(item.ticket_number ?? "")),
                            Expanded(
                              child: Center(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                    vertical: 4.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        item.status == 'NON_CONFORM'
                                            ? Colors.orange[200]
                                            : Colors.green[200],
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: Text(
                                    item.status == "CONFORM"
                                        ? "Terminé"
                                        : "en cours",
                                    style: TextStyle(
                                      color:
                                          item.status == 'NON_CONFORM'
                                              ? Colors.orange[800]
                                              : Colors.green[800],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Checkbox(
                                  value: item.status == "CONFORM",
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _actionItems[index].status =
                                          value == true
                                              ? "CONFORM"
                                              : "NON_CONFORM";
                                    });
                                  },
                                  activeColor: AppColors.attijariSuccess,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 20.0),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implement logic for "Plan d'action terminé"
                  print('Plan d\'action terminé clicked');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.attijariError,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32.0,
                    vertical: 16.0,
                  ),
                  textStyle: const TextStyle(fontSize: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Plan d\'action terminé',
                  style: TextStyle(color: attijariWhite),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
