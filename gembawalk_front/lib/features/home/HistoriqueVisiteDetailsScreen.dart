import 'package:flutter/material.dart';
import 'package:gembawalk_front/config/colors.dart';
import 'package:gembawalk_front/core/models/checklist_item_reponse.dart';
import '../../core/service/planAction_api_service.dart';

class HistoriqueVisiteDetailsScreen extends StatefulWidget {
  final int visitId;

  const HistoriqueVisiteDetailsScreen({super.key, required this.visitId});

  @override
  State<HistoriqueVisiteDetailsScreen> createState() =>
      _HistoriqueVisiteDetailsScreenState();
}

class _HistoriqueVisiteDetailsScreenState
    extends State<HistoriqueVisiteDetailsScreen> {
  late final PlanactionApiService planactionApiService;
  late Future<List<ChecklistItemReponseModel>> HistoryItems;

  @override
  void initState() {
    super.initState();
    planactionApiService = PlanactionApiService();
    HistoryItems = planactionApiService.getVisitHistoryDetails(widget.visitId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Historique',
          style: TextStyle(color: AppColors.white),
        ),
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: AppColors.white),
      ),
      backgroundColor: AppColors.background,
      body: FutureBuilder<List<ChecklistItemReponseModel>>(
        future: HistoryItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Erreur: ${snapshot.error}',
                style: const TextStyle(color: AppColors.attijariError),
              ),
            );
          }

          final responses = snapshot.data ?? [];

          final grouped = <String, List<ChecklistItemReponseModel>>{};
          for (var item in responses) {
            grouped.putIfAbsent(item.rubrique_name, () => []).add(item);
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: grouped.length,
            itemBuilder: (context, index) {
              final rubriqueName = grouped.keys.elementAt(index);
              final items = grouped[rubriqueName]!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      rubriqueName,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ...items.map(
                    (item) => Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.item_name,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Commentaire: ${item.comment ?? 'Aucun'}",
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            if (item.ticket_number != null) ...[
                              const SizedBox(height: 2),
                              Text(
                                "Ticket #: ${item.ticket_number}",
                                style: const TextStyle(color: AppColors.info),
                              ),
                            ],
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _statusChip(item.status),
                                Row(
                                  children: [
                                    if (item.resolved == true)
                                      const Icon(
                                        Icons.build_circle_rounded,
                                        color: AppColors.attijariSuccess,
                                      ),
                                    if (item.confirmed == true)
                                      const Icon(
                                        Icons.verified_rounded,
                                        color: AppColors.info,
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _statusChip(String? status) {
    if (status == 'CONFORM') {
      return Chip(
        label: const Text("Conforme", style: TextStyle(color: AppColors.white)),
        backgroundColor: AppColors.attijariSuccess,
      );
    } else if (status == 'NON_CONFORM') {
      return Chip(
        label: const Text(
          "Non Conforme",
          style: TextStyle(color: AppColors.white),
        ),
        backgroundColor: AppColors.attijariError,
      );
    }
    return const Chip(
      label: Text("Non défini"),
      backgroundColor: AppColors.gray3,
    );
  }
}
