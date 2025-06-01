import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:gembawalk_front/config/colors.dart';

class DashboardScreen extends StatefulWidget {
  final String userName;
  final String userRole;

  const DashboardScreen({
    Key? key,
    required this.userName,
    required this.userRole,
  }) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Map<String, dynamic>> recentVisits = [];
  String totalVisits = '0';
  String ongoingVisits = '0';
  String completedVisits = '0';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    print(
      "********************************** DASHBOARD INIT STATE ************************************",
    );
    fetchDashboardData();
  }

  Future<void> fetchDashboardData() async {
    try {
      final visitsResponse = await http.get(
        Uri.parse(
          'http://${dotenv.get('LOCALIP')}:8080/api/dashboard/recent_visits',
        ),
      );
      final statsResponse = await http.get(
        Uri.parse('http://${dotenv.get('LOCALIP')}:8080/api/dashboard/stats'),
      );

      if (visitsResponse.statusCode == 200 && statsResponse.statusCode == 200) {
        print(
          "********************************** DASHBOARD SENT REQUEST success ************************************",
        );
        final visits = json.decode(visitsResponse.body);
        final stats = json.decode(statsResponse.body);

        print("********** stats : ${stats}");

        setState(() {
          recentVisits = List<Map<String, dynamic>>.from(visits);
          totalVisits = stats['totalVisit'].toString();
          ongoingVisits = stats['visiteActive'].toString();
          completedVisits = stats['visitNonActive'].toString();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      print('Error fetching dashboard data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          'Tableau de bord',
          style: TextStyle(color: AppColors.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final isWide = constraints.maxWidth >= 600;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _Header(
                              userName: widget.userName,
                              userRole: widget.userRole,
                            ),
                            const SizedBox(height: 24),
                            isWide
                                ? Column(
                                  children: [
                                    Row(
                                      children: [
                                        SummaryCard(
                                          title: 'Total des visites',
                                          value: totalVisits,
                                          color: AppColors.primary,
                                        ),
                                        const SizedBox(width: 16),
                                        SummaryCard(
                                          title: 'Visites en cours',
                                          value: ongoingVisits,
                                          color: AppColors.secondary,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      children: [
                                        SummaryCard(
                                          title: 'Visites terminées',
                                          value: completedVisits,
                                          color: AppColors.attijariSuccess,
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                                : Column(
                                  children: [
                                    SummaryCard(
                                      title: 'Total des visites',
                                      value: totalVisits,
                                      color: AppColors.primary,
                                    ),
                                    const SizedBox(height: 8),
                                    SummaryCard(
                                      title: 'Visites en cours',
                                      value: ongoingVisits,
                                      color: AppColors.secondary,
                                    ),
                                    const SizedBox(height: 8),
                                    SummaryCard(
                                      title: 'Visites terminées',
                                      value: completedVisits,
                                      color: AppColors.attijariSuccess,
                                    ),
                                  ],
                                ),
                            const SizedBox(height: 24),
                            const Text(
                              'Visites récentes',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Expanded(
                              child: _RecentVisitsList(
                                recentVisits: recentVisits,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
    );
  }
}
/* List<Widget> _buildSummaryCards() {
    return [
      SummaryCard(
        title: 'Total des visites',
        value: '15',
        color: AppColors.primary,
      ),
      SummaryCard(
        title: 'Visites en cours',
        value: '3',
        color: AppColors.secondary,
      ),
      SummaryCard(
        title: 'Visites terminées',
        value: '10',
        color: AppColors.attijariSuccess,
      ),
    ];
  }
} */

class _Header extends StatelessWidget {
  final String userName;
  final String userRole;

  const _Header({Key? key, required this.userName, required this.userRole})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bienvenue',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        /* Text(
          'Rôle : $userRole',
          style: const TextStyle(fontSize: 16, color: AppColors.textSecondary),
        ), */
      ],
    );
  }
}

class SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const SummaryCard({
    Key? key,
    required this.title,
    required this.value,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: AppColors.inputBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          child: Column(
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecentVisitsList extends StatelessWidget {
  final List<Map<String, dynamic>> recentVisits;

  const _RecentVisitsList({Key? key, required this.recentVisits})
    : super(key: key);

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Terminé':
        return AppColors.attijariSuccess;
      case 'En cours':
        return AppColors.secondary;
      default: // For "En attente" and any other status
        return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: recentVisits.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        final visit = recentVisits[index];
        final DateTime dt = DateTime.parse(visit['createdAt']);
        String formatted =
            "${_twoDigits(dt.day)}/${_twoDigits(dt.month)}/${dt.year} - ${_twoDigits(dt.hour)}:${_twoDigits(dt.minute)}";
        final status = visit['active'] == true ? 'En cours' : 'Terminé';
        return ListTile(
          leading: const Icon(Icons.location_on, color: AppColors.primary),
          title: Text(
            visit['aganceName'] ?? '',
            style: const TextStyle(color: AppColors.textPrimary),
          ),
          subtitle: Text(
            'Date : ${formatted} - Statut : $status',
            style: TextStyle(
              color: _getStatusColor(status),
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: const Icon(Icons.chevron_right, color: AppColors.secondary),
          onTap: () {
            // TODO: Ajouter la navigation vers le détail de la visite si besoin
          },
        );
      },
    );
  }
}

String _twoDigits(int n) => n.toString().padLeft(2, '0');
