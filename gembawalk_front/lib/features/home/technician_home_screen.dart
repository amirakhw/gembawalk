import 'package:flutter/material.dart';
import 'package:gembawalk_front/config/theme.dart';

import 'tech_plan_daction_screen.dart';

class TechnicianHomeScreen extends StatelessWidget {
  const TechnicianHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> agencies = [
      'Agence Tunis Centre',
      'Agence Sfax Médina',
      'Agence Djerba Midoun',
      'Agence Bizerte Corniche',
      'Agence Monastir Ribat',
    ];

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
        // Center the content on larger screens
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 600,
          ), // Limit maximum width
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
                            (context) => const TechPlanDactionScreen(
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
