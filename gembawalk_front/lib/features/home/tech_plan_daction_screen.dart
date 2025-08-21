import 'package:flutter/material.dart';
import 'package:gembawalk_front/config/theme.dart';
import 'package:gembawalk_front/config/colors.dart';
import 'package:gembawalk_front/core/models/checklist_item_reponse.dart';
import 'package:gembawalk_front/core/models/planAction.dart';
import 'package:gembawalk_front/core/service/planAction_api_service.dart';

class TechPlanDActionScreen extends StatefulWidget {
  final PlanActionModel visit;

  const TechPlanDActionScreen({super.key, required this.visit});

  @override
  State<TechPlanDActionScreen> createState() => _TechPlanDActionScreenState();
}

class _TechPlanDActionScreenState extends State<TechPlanDActionScreen> {
  late final PlanactionApiService planactionApiService;
  late Future<List<ChecklistItemReponseModel>> actionItems;

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

  void setResolved(ChecklistItemReponseModel item) async {
    try {
      await planactionApiService.postResolveStatus(item.id, true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(" Échec de la mise à jour du statut"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<bool> showConfirmationDialog(
    BuildContext context, {
    String title = 'Confirmation',
    String content = 'Êtes-vous sûr de vouloir marquer comme résolu ?',
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
          'Plan d\'Action - Agence ${widget.visit.id}',
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
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (item.resolved == false) {
                                      final confirmPopUP =
                                          await showConfirmationDialog(context);

                                      if (confirmPopUP) {
                                        setResolved(item);
                                        setState(() {
                                          _actionItems[index].resolved = true;
                                        });
                                      }
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        item.resolved == true
                                            ? AppColors.attijariSuccess
                                                .withOpacity(0.2)
                                            : AppColors.secondary.withOpacity(
                                              0.2,
                                            ),
                                    foregroundColor:
                                        item.resolved == true
                                            ? AppColors.attijariSuccess
                                            : AppColors.secondary,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                      vertical: 4.0,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                  ),
                                  child: Text(
                                    item.resolved == true
                                        ? "Résolu"
                                        : "En cours",
                                    style: const TextStyle(
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
                                  onChanged: null,
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
            ],
          ),
        ),
      ),
    );
  }

  TextStyle _headerStyle() =>
      const TextStyle(fontWeight: FontWeight.bold, color: attijariTextPrimary);
}
