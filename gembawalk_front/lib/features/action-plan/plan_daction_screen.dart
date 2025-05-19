import 'package:flutter/material.dart';
import 'package:gembawalk_front/config/theme.dart';
import 'package:gembawalk_front/config/colors.dart';

class PlanDActionScreen extends StatefulWidget {
  final String agencyId;

  const PlanDActionScreen({super.key, required this.agencyId});

  @override
  State<PlanDActionScreen> createState() => _PlanDActionScreenState();
}

class _PlanDActionScreenState extends State<PlanDActionScreen> {
  // Placeholder data for the action plan items
  final List<Map<String, dynamic>> _actionItems = [
    {'rubrique': 'Mobilier', 'item': 'Table', 'ticket': 'T12345', 'etat': 'en cours', 'confirme': true},
    {'rubrique': 'Mobilier', 'item': 'Chaise', 'ticket': 'T12346', 'etat': 'terminé', 'confirme': true},
    {'rubrique': 'Portes et Fenêtres', 'item': 'La porte', 'ticket': 'T12347', 'etat': 'en cours', 'confirme': false},
    {'rubrique': 'Équipement IT', 'item': 'Écran', 'ticket': 'T12348', 'etat': 'en cours', 'confirme': false},
    {'rubrique': 'Clavier', 'item': 'Clavier', 'ticket': 'T12349', 'etat': 'terminé', 'confirme': true},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: attijariPrimary,
        title: Text(
          'Plan d\'Action - Agence ${widget.agencyId}',
          style: const TextStyle(color: attijariWhite, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: attijariWhite),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Table Header
            Row(
              children: const [
                Expanded(flex: 2, child: Text('Item', style: TextStyle(fontWeight: FontWeight.bold, color: attijariTextPrimary))),
                Expanded(child: Text('Numéro de ticket', style: TextStyle(fontWeight: FontWeight.bold, color: attijariTextPrimary))),
                Expanded(child: Center(child: Text('État', style: TextStyle(fontWeight: FontWeight.bold, color: attijariTextPrimary)))),
                Expanded(child: Center(child: Text('Confirmé par visiteur', style: TextStyle(fontWeight: FontWeight.bold, color: attijariTextPrimary)))),
              ],
            ),
            const Divider(),
            // Table Rows
            Expanded(
              child: ListView.builder(
                itemCount: _actionItems.length,
                itemBuilder: (context, index) {
                  final item = _actionItems[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(flex: 2, child: Text(item['item'])),
                        Expanded(child: Text(item['ticket'])),
                        Expanded(
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                              decoration: BoxDecoration(
                                color: item['etat'] == 'en cours' ? Colors.orange[200] : Colors.green[200],
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Text(
                                item['etat'],
                                style: TextStyle(
                                  color: item['etat'] == 'en cours' ? Colors.orange[800] : Colors.green[800],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Checkbox(
                              value: item['confirme'],
                              onChanged: (bool? value) {
                                setState(() {
                                  _actionItems[index]['confirme'] = value ?? false;
                                });
                              },
                              activeColor: AppColors.attijariSuccess,

                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20.0),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implement logic for "Plan d'action terminé"
                  print('Plan d\'action terminé clicked');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.attijariError,
                  padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                  textStyle: const TextStyle(fontSize: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text('Plan d\'action terminé', style: TextStyle(color: attijariWhite)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}