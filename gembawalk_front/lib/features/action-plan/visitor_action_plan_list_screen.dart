import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gembawalk_front/config/colors.dart';
import 'package:gembawalk_front/core/models/planAction.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../NotifierProviders/all_data.dart';
import '../../core/models/visit.dart';
import 'visitor_plan_daction_screen.dart';
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          'Plans d\'action par agence',
          style: TextStyle(
            color: attijariWhite,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        iconTheme: const IconThemeData(color: attijariWhite),
        elevation: 4,
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: ListView.separated(
              itemCount: planactionList.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final agencyName = planactionList[index].agence_name;
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
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                    title: Text(
                      agencyName,
                      style: attijariTheme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: attijariTextPrimary,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.primary,
                      size: 18,
                    ),
                    onTap: () {
                      Navigator.push<int>(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => PlanDActionScreen(
                                visit: planactionList[index],
                              ),
                        ),
                      ).then(
                        (id) => setState(() {
                          print('Returned id: $id');
                          if (id != null) {
                            setState(() {
                              planactionList.removeWhere((v) => (v.id == id));
                            });
                          }
                        }),
                      );

                      print('Tapped on $agencyName');
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
