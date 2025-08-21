import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gembawalk_front/config/colors.dart';
import 'package:http/http.dart' as http;
import '../../core/models/visit_history_model.dart';
import 'HistoriqueVisiteDetailsScreen.dart';

class HistoriqueVisitesScreen extends StatefulWidget {
  const HistoriqueVisitesScreen({super.key});

  @override
  State<HistoriqueVisitesScreen> createState() =>
      _HistoriqueVisitesScreenState();
}

class _HistoriqueVisitesScreenState extends State<HistoriqueVisitesScreen> {
  late Future<List<VisitHistoryModel>> _visitsFuture;
  //List<VisitHistoryModel> HistoriqueList = [];
  final userId = 2;

  @override
  void initState() {
    super.initState();
    _visitsFuture = fetchVisitHistory(userId);
  }

  Future<List<VisitHistoryModel>> fetchVisitHistory(int userId) async {
    final response = await http.get(
      Uri.parse(
        'http://${dotenv.get('LOCALIP')}:8080/api/visits/query/user/$userId',
      ),
    );
    if (response.statusCode == 200) {
      List<dynamic> _rep = jsonDecode(response.body);
      List<VisitHistoryModel> list =
          _rep.map((el) => VisitHistoryModel.fromJson(el)).toList();
      setState(() {
        //HistoriqueList = list;
      });
      return list;
    } else {
      _showErrorSnackBar('Erreur lors du chargement des visites.');
      return [];
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  String _twoDigits(int n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          'Historique des Visites',
          style: TextStyle(
            color: AppColors.background,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: AppColors.background),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<VisitHistoryModel>>(
          future: _visitsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erreur: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Aucune visite trouvée.'));
            }

            final visits = snapshot.data!;
            return ListView.builder(
              itemCount: visits.length,
              itemBuilder: (context, index) {
                final visit = visits[index];
                final DateTime dt = visit.created_at;
                String formatted =
                    "${_twoDigits(dt.day)}/${_twoDigits(dt.month)}/${dt.year} - ${_twoDigits(dt.hour)}:${_twoDigits(dt.minute)}";
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    title: Text(
                      visit.agence_name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Date: ${formatted}'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => HistoriqueVisiteDetailsScreen(
                                visitId: visit.id,
                              ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
