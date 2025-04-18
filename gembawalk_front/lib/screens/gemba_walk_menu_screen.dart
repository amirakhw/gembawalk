import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'facade_screen.dart';
import 'enseignes_lumineuses_screen.dart'; // Import the next screen

class GembaWalkMenuScreen extends StatefulWidget {
  final int regionId;
  final int groupId;
  final int agenceId;
  final String? regionName;
  final String? groupName;
  final String? agenceName;

  const GembaWalkMenuScreen({
    super.key,
    required this.regionId,
    required this.groupId,
    required this.agenceId,
    this.regionName,
    this.groupName,
    this.agenceName,
  });

  @override
  State<GembaWalkMenuScreen> createState() => _GembaWalkMenuScreenState();
}

class _GembaWalkMenuScreenState extends State<GembaWalkMenuScreen> {
  final List<String> _rubriques = [
    'Façade',
    'Enseignes lumineuses',
    'Agent de sécurité',
    'Femme de ménage',
    'Directeur d\'agence',
    'Conseillé de Clientèle',
    'Gestionnaire de Clientèle Principal',
    'Guichet',
    'Outils & Session',
    'Chambre et coffre fort',
    'Chambre GAB',
    'Bloc Sanitaire',
    'Infrastructure et Matériel',
    'Environnement et Matériel',
    'Extincteurs',
  ];

  final List<bool> _rubriqueStatus = List.generate(15, (index) => false);
  final List<Map<String, dynamic>> _rubriqueData = List.generate(15, (index) => {});

  bool get _allSectionsDone => _rubriqueStatus.every((status) => status);

  void _updateRubriqueStatus(int index, bool isDone) {
    setState(() {
      _rubriqueStatus[index] = isDone;
    });
  }

  void _updateRubriqueData(int index, Map<String, dynamic> data) {
    setState(() {
      _rubriqueData[index] = data;
      if (data.isNotEmpty) {
        _rubriqueStatus[index] = true;
      } else {
        _rubriqueStatus[index] = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: attijariPrimary,
        title: const Text('Gemba Walk', style: TextStyle(color: attijariWhite, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: attijariWhite),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.regionName != null)
                  Text(
                    'Région: ${widget.regionName}',
                    style: const TextStyle(fontSize: 16.0, color: attijariTextSecondary, fontWeight: FontWeight.bold),
                  ),
                if (widget.regionName != null) const SizedBox(height: 8.0),
                if (widget.groupName != null)
                  Text(
                    'Groupe: ${widget.groupName}',
                    style: const TextStyle(fontSize: 16.0, color: attijariTextSecondary, fontWeight: FontWeight.bold),
                  ),
                if (widget.groupName != null) const SizedBox(height: 8.0),
                if (widget.agenceName != null)
                  Text(
                    'Agence: ${widget.agenceName}',
                    style: const TextStyle(fontSize: 16.0, color: attijariTextSecondary, fontWeight: FontWeight.bold),
                  ),
                if (widget.agenceName != null) const SizedBox(height: 16.0),
                Expanded(
                  child: ListView.builder(
                    itemCount: _rubriques.length,
                    itemBuilder: (context, index) {
                      final isDone = _rubriqueStatus[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: isDone ? Colors.green.shade300 : attijariGray3,
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: InkWell(
                          onTap: () async {
                            if (index == 0) {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FacadeScreen(initialData: _rubriqueData[index]),
                                ),
                              );
                              if (result != null && result is Map<String, dynamic>) {
                                _updateRubriqueData(index, result);
                              }
                            } else if (index == 1) {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const EnseignesLumineusesScreen(), // Pass initialData later
                                ),
                              );
                              if (result != null && result is Map<String, dynamic>) {
                                _updateRubriqueData(index, result);
                              }
                            } else {
                              // TODO: Navigate to the screen for ${_rubriques[index]}
                              print('Tapped on ${_rubriques[index]} - Navigation to its screen will be implemented later.');
                              _updateRubriqueStatus(index, !_rubriqueStatus[index]); // Keep visual feedback
                            }
                          },
                          borderRadius: BorderRadius.circular(10.0),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              _rubriques[index],
                              style: TextStyle(fontSize: 16.0, color: attijariTextPrimary),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 70.0),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _allSectionsDone
                      ? () {
                          // TODO: Implement submit functionality
                          print('Soumettre');
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _allSectionsDone ? Colors.orange.shade700 : Colors.grey.shade600,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    'Soumettre',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}