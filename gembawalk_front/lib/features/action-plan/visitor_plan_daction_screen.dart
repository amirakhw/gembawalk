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
  bool isPAFinished = false;

  @override
  void initState() {
    super.initState();
    planactionApiService = PlanactionApiService();
    actionItems = planactionApiService
        .fetchChecklistResponse(widget.visit.id)
        .then(
          (list) => list.where((item) => item.status == 'NON_CONFORM').toList(),
        );
  }

  void setConfirmed(ChecklistItemReponseModel item) async {
    try {
      await planactionApiService.postConfirmStatus(item.id, true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(" Échec de la mise à jour du confirmé"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void terminate() async {
    try {
      await planactionApiService.terminate(widget.visit.id);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(" Échec de Clôturer le Plan d'action"),
          backgroundColor: Colors.red,
        ),
      );
    }
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          'Plan d\'Action - Agence ${widget.visit.agence_name}',
          style: const TextStyle(
            color: attijariWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: attijariWhite),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Table Header
              Row(
                children: [
                  Expanded(flex: 2, child: Text('Item', style: _headerStyle())),
                  Expanded(
                    child: Text('Numéro de ticket', style: _headerStyle()),
                  ),
                  Expanded(
                    child: Center(child: Text('État', style: _headerStyle())),
                  ),
                  Expanded(
                    child: Center(
                      child: Text('Confirmé', style: _headerStyle()),
                    ),
                  ),
                ],
              ),
              const Divider(height: 20, thickness: 1),

              /// MAIN LIST - Expanded to avoid overflow
              Expanded(
                child: FutureBuilder<List<ChecklistItemReponseModel>>(
                  future: actionItems,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Erreur : ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text('Aucun plan d\'action disponible.'),
                      );
                    }

                    final _actionItems = snapshot.data!;

                    isPAFinished =
                        !_actionItems.any(
                          (item) =>
                              item.status == "NON_CONFORM" &&
                              !(item.confirmed == true),
                        );

                    print(
                      "**************is finished check : ${isPAFinished}------------------",
                    );

                    return ListView.separated(
                      itemCount: _actionItems.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final item = _actionItems[index];

                        return Row(
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
                                        item.resolved == true
                                            ? AppColors.attijariSuccess
                                                .withOpacity(0.2)
                                            : AppColors.secondary.withOpacity(
                                              0.2,
                                            ),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: Text(
                                    item.resolved == true
                                        ? "résolu"
                                        : "En cours",
                                    style: TextStyle(
                                      color:
                                          item.resolved == true
                                              ? AppColors.attijariSuccess
                                              : AppColors.secondary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Checkbox(
                                  value: item.confirmed,

                                  onChanged: (bool? value) async {
                                    if (item.confirmed == false &&
                                        item.resolved == true) {
                                      final confirmPopUP =
                                          await showConfirmationDialog(context);

                                      if (confirmPopUP) {
                                        setConfirmed(item);
                                        setState(() {
                                          _actionItems[index].confirmed = true;
                                        });
                                      }
                                    }
                                  },
                                  activeColor: AppColors.attijariSuccess,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),

              /// ✅ FIXED BUTTON (always visible)
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:
                      () => {
                        isPAFinished
                            ? () async {
                              final confirmPopUP = await showConfirmationDialog(
                                context,
                                content:
                                    'Êtes-vous sûr de vouloir clôturer ce plan d\'action ?',
                              );

                              if (confirmPopUP) {
                                print('Clôturer ce plan d\'action');
                                terminate();
                                Navigator.pop(context, widget.visit.id);
                              }
                            }()
                            : () async {
                              await showConfirmationDialog(
                                context,
                                content:
                                    'kamel confirmi el items 9bal clôturer ce plan d\'action',
                                confirmText: "behi",
                                cancelText: "sama7ni",
                              );
                            }(),
                      },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.attijariError,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'Plan d\'action terminé',
                    style: TextStyle(color: attijariWhite, fontSize: 16.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle _headerStyle() =>
      const TextStyle(fontWeight: FontWeight.bold, color: attijariTextPrimary);
}
