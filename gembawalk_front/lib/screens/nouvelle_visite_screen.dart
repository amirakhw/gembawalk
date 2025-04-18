import 'package:flutter/material.dart';
import 'login_screen.dart'; // For Attijari theme colors
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'gemba_walk_menu_screen.dart';

class NouvelleVisiteScreen extends StatefulWidget {
  const NouvelleVisiteScreen({super.key});

  @override
  State<NouvelleVisiteScreen> createState() => _NouvelleVisiteScreenState();
}

class _NouvelleVisiteScreenState extends State<NouvelleVisiteScreen> {
  int? _selectedRegionId;
  int? _selectedGroupId;
  int? _selectedAgenceId;

  List<Map<String, dynamic>> _regions = [];
  List<Map<String, dynamic>> _groupes = [];
  List<Map<String, dynamic>> _agences = [];

  @override
  void initState() {
    super.initState();
    _fetchRegions();
  }

  Future<void> _fetchRegions() async {
    final response = await http.get(Uri.parse('http://192.168.181.250:8080/api/regions'));
    if (response.statusCode == 200) {
      setState(() {
        _regions = List<Map<String, dynamic>>.from(jsonDecode(response.body));
        print('Regions List: $_regions');
      });
    } else {
      _showErrorSnackBar('Erreur lors du chargement des régions.');
    }
  }

  Future<void> _fetchGroups(int regionId) async {
    final response = await http.get(
      Uri.parse('http://192.168.181.250:8080/api/groups?regionId=$regionId'),
    );
    if (response.statusCode == 200) {
      setState(() {
        _groupes = List<Map<String, dynamic>>.from(jsonDecode(response.body));
        _selectedGroupId = null;
        _agences = [];
        _selectedAgenceId = null;
        print('Groups List for region $regionId: $_groupes');
      });
    } else {
      _showErrorSnackBar('Erreur lors du chargement des groupes.');
    }
  }

  Future<void> _fetchAgencies(int groupId) async {
    final response = await http.get(
      Uri.parse('http://192.168.181.250:8080/api/agencies?groupId=$groupId'),
    );
    if (response.statusCode == 200) {
      setState(() {
        _agences = List<Map<String, dynamic>>.from(jsonDecode(response.body));
        _selectedAgenceId = null;
        print('Agencies List for group $groupId: $_agences');
      });
    } else {
      _showErrorSnackBar('Erreur lors du chargement des agences.');
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // Helper widget to build dropdown items.
  List<DropdownMenuItem<int>> _buildDropdownItems(List<Map<String, dynamic>> items) {
    return items.map((item) {
      return DropdownMenuItem<int>(
        value: item['id'],
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          child: Text(
            item['name'],
            style: const TextStyle(fontSize: 16.0, color: attijariTextSecondary),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: attijariPrimary,
        title: const Text(
          'Détails de la visite',
          style: TextStyle(color: attijariWhite, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: attijariWhite),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Sélectionnez les détails de la visite',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: attijariTextPrimary),
            ),
            const SizedBox(height: 32.0),
            // REGION DROPDOWN
            DropdownButtonFormField<int>(
              isExpanded: true,
              decoration: InputDecoration(
                labelText: 'Région',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: attijariPrimary, width: 1.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                filled: true,
                fillColor: attijariWhite,
              ),
              dropdownColor: attijariWhite,
              style: const TextStyle(fontSize: 16.0, color: attijariTextPrimary),
              value: _selectedRegionId,
              items: _buildDropdownItems(_regions),
              selectedItemBuilder: (BuildContext context) {
                return _regions.map<Widget>((item) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      item['name'],
                      style: const TextStyle(
                        color: attijariTextPrimary,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList();
              },
              onChanged: (int? newValue) {
                setState(() {
                  _selectedRegionId = newValue;
                  _selectedGroupId = null;
                  _selectedAgenceId = null;
                  _groupes = [];
                  _agences = [];
                });
                if (newValue != null) {
                  _fetchGroups(newValue);
                }
              },
            ),
            const SizedBox(height: 16.0),
            // GROUPE DROPDOWN
            DropdownButtonFormField<int>(
              isExpanded: true,
              decoration: InputDecoration(
                labelText: 'Groupe',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: attijariPrimary, width: 1.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                filled: true,
                fillColor: attijariWhite,
              ),
              dropdownColor: attijariWhite,
              style: const TextStyle(fontSize: 16.0, color: attijariTextPrimary),
              value: _selectedGroupId,
              items: _buildDropdownItems(_groupes),
              selectedItemBuilder: (BuildContext context) {
                return _groupes.map<Widget>((item) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      item['name'],
                      style: const TextStyle(
                        color: attijariTextPrimary,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList();
              },
              onChanged: (int? newValue) {
                setState(() {
                  _selectedGroupId = newValue;
                  _selectedAgenceId = null;
                  _agences = [];
                });
                if (newValue != null) {
                  _fetchAgencies(newValue);
                }
              },
            ),
            const SizedBox(height: 16.0),
            // AGENCE DROPDOWN
            DropdownButtonFormField<int>(
              isExpanded: true,
              decoration: InputDecoration(
                labelText: 'Agence',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: attijariPrimary, width: 1.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                filled: true,
                fillColor: attijariWhite,
              ),
              dropdownColor: attijariWhite,
              style: const TextStyle(fontSize: 16.0, color: attijariTextPrimary),
              value: _selectedAgenceId,
              items: _buildDropdownItems(_agences),
              selectedItemBuilder: (BuildContext context) {
                return _agences.map<Widget>((item) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      item['name'],
                      style: const TextStyle(
                        color: attijariTextPrimary,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList();
              },
              onChanged: (int? newValue) {
                setState(() {
                  _selectedAgenceId = newValue;
                });
                // TODO: Perform any action based on the selected agency
              },
            ),
            const SizedBox(height: 48.0),
            SizedBox(
              width: double.infinity,
              height: 50.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: attijariPrimary,
                  textStyle: const TextStyle(fontSize: 20.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                 onPressed: () {
                  if (_selectedRegionId != null && _selectedGroupId != null && _selectedAgenceId != null) {
                    final selectedRegion = _regions.firstWhere((r) => r['id'] == _selectedRegionId);
                    final selectedGroup = _groupes.firstWhere((g) => g['id'] == _selectedGroupId);
                    final selectedAgence = _agences.firstWhere((a) => a['id'] == _selectedAgenceId);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GembaWalkMenuScreen(
                          regionId: _selectedRegionId!,
                          groupId: _selectedGroupId!,
                          agenceId: _selectedAgenceId!,
                          regionName: selectedRegion['name'] as String, // Pass the name
                          groupName: selectedGroup['name'] as String,   // Pass the name
                          agenceName: selectedAgence['name'] as String, // Pass the name
                        ),
                      ),
                    );
                  } else {
                    _showErrorSnackBar('Veuillez sélectionner la région, le groupe et l\'agence.');
                  }
                },
                child: const Text('Commencer la visite', style: TextStyle(color: attijariWhite)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}