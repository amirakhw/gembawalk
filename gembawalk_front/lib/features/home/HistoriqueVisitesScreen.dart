import 'package:flutter/material.dart';
import 'package:gembawalk_front/config/theme.dart';
import 'VisiteDetailsScreen.dart';


class HistoriqueVisitesScreen extends StatelessWidget {
  // Mock data for visited agencies.  In a real app, this would come from a database or API.
  final List<Map<String, dynamic>> _visitedAgencies = [
    {
      'id': 1,
      'name': 'Agence Principale',
      'date': '2024-07-24',
      'rubriques': [
        {
          'title': 'Façade',
          'conformity': {'Habillage GAB': 'conforme', 'Revêtement Marbre': 'non conforme'},
          'comments': {'Habillage GAB': '', 'Revêtement Marbre': 'Marbre fissuré'},
          'ticketNumbers': {'Habillage GAB': '', 'Revêtement Marbre': 'TKT-12345'},
          'images': [],
        },
        {
          'title': 'Enseignes lumineuses',
          'conformity': {'Enseigne 1': 'conforme', 'Enseigne 2': 'conforme'},
          'comments': {'Enseigne 1': '', 'Enseigne 2': ''},
          'ticketNumbers': {'Enseigne 1': '', 'Enseigne 2': ''},
          'images': [],
        },
      ],
    },
    {
      'id': 2,
      'name': 'Agence Quartier X',
      'date': '2024-07-23',
      'rubriques': [
        {
          'title': 'Façade',
          'conformity': {'Habillage GAB': 'non conforme', 'Revêtement Marbre': 'conforme'},
          'comments': {'Habillage GAB': 'Besoin de réparation', 'Revêtement Marbre': ''},
          'ticketNumbers': {'Habillage GAB': 'TKT-54321', 'Revêtement Marbre': ''},
          'images': [],
        },
        {
          'title': 'Guichet',
          'conformity': {'Guichet 1': 'conforme', 'Guichet 2': 'non conforme'},
          'comments': {'Guichet 1': '', 'Guichet 2': 'Problème tiroir caisse'},
          'ticketNumbers': {'Guichet 1': '', 'Guichet 2': 'TKT-98765'},
          'images': [],
        },
      ],
    },
    {
      'id': 3,
      'name': 'Agence Y',
      'date': '2024-07-20',
      'rubriques': [
        {
          'title': 'Bloc Sanitaire',
          'conformity': {'État général': 'non conforme', 'Propreté': 'non conforme'},
          'comments': {'État général': 'Nécessite rénovation', 'Propreté': 'Sale'},
          'ticketNumbers': {'État général': 'TKT-2468', 'Propreté': 'TKT-1357'},
          'images': [],
        },
      ]
    }
  ];

  HistoriqueVisitesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: attijariPrimary,
        title: const Text('Historique des Visites',
            style: TextStyle(color: attijariWhite, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: attijariWhite),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: _visitedAgencies.length,
          itemBuilder: (context, index) {
            final agency = _visitedAgencies[index];
            return Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                title: Text(agency['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('Date: ${agency['date']}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VisiteDetailsScreen(
                        agencyName: agency['name'],
                        rubriques: agency['rubriques'],
                      ),
                    ),
                  );
                },
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              ),
            );
          },
        ),
      ),
    );
  }
}