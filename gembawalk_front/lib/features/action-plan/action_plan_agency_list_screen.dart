import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gembawalk_front/core/models/planAction.dart';
import 'package:http/http.dart' as http;
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
  late List<PlanActionModel> planactionList;
  List<String> agenciesFullName = [];

  @override
  void initState() {
    super.initState();
    _fetchAgencies();
  }

  Future<void> _fetchAgencies() async {
    final response = await http.get(
      Uri.parse('http://${dotenv.get('LOCALIP')}:8080/api/visits/query/active'),
    );
    if (response.statusCode == 200) {
      List<Map<String, dynamic>> _rep = List<Map<String, dynamic>>.from(
        jsonDecode(response.body),
      );
      setState(() {
        planactionList =
            (_rep as List).map((el) => PlanActionModel.fromJson(el)).toList();

        print('Regions: $agenciesFullName');
      });
    } else {
      _showErrorSnackBar('Erreur lors du chargement des agences.');
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    //visitList = Provider.of<LocalDB>(context, listen: false).localDB;
    //agencies = visitList.map((visit) => visit.agence_name).toList();

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
            itemCount: planactionList.length,
            itemBuilder: (context, index) {
              final agencyName = planactionList[index].agence_name;
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
                            (context) =>
                                PlanDActionScreen(visit: planactionList[index]),
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
