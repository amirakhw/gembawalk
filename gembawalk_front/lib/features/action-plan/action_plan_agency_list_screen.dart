import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../NotifierProviders/all_data.dart';
import '../../core/models/visit.dart';
import 'plan_daction_screen.dart';
import 'package:gembawalk_front/config/theme.dart';

class ActionPlanAgencyListScreen extends StatefulWidget {
  const ActionPlanAgencyListScreen({super.key});

  @override
  State<ActionPlanAgencyListScreen> createState() =>
      _ActionPlanAgencyListScreenState();
}

class _ActionPlanAgencyListScreenState
    extends State<ActionPlanAgencyListScreen> {
  late List<Visit> visitList;
  List<String> agencies = [];

  @override
  Widget build(BuildContext context) {
    visitList = Provider.of<LocalDB>(context, listen: false).localDB;
    agencies = visitList.map((visit) => visit.agence_name).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: attijariPrimary,
        title: const Text(
          'Plans d\'action par agence',
          style: TextStyle(color: attijariWhite, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: attijariWhite),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: ListView.builder(
            itemCount: agencies.length,
            itemBuilder: (context, index) {
              final agencyName = agencies[index];
              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ListTile(
                  title: Text(
                    agencyName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: attijariTextPrimary,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => const PlanDActionScreen(
                              agencyId: 'PLACEHOLDER_ID',
                            ),
                      ),
                    );
                    print('Tapped on $agencyName');
                  },
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: attijariPrimary,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
