// Optimised version of NouvelleVisiteScreen
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gembawalk_front/config/theme.dart';
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
    final response = await http.get(Uri.parse('http://'+ dotenv.get('LOCALIP') +':8080/api/regions'));
    if (response.statusCode == 200) {
      setState(() {
        _regions = List<Map<String, dynamic>>.from(jsonDecode(response.body));
        print('Regions: $_regions');
      });
    } else {
      _showErrorSnackBar('Erreur lors du chargement des régions.');
    }
  }

  Future<void> _fetchGroups(int regionId) async {
    final response = await http.get(Uri.parse('http://'+ dotenv.get('LOCALIP') +':8080/api/groups?regionId=$regionId'));
    if (response.statusCode == 200) {
      setState(() {
        _groupes = List<Map<String, dynamic>>.from(jsonDecode(response.body));
        _selectedGroupId = null;
        _agences = [];
        _selectedAgenceId = null;
      });
    } else {
      _showErrorSnackBar('Erreur lors du chargement des groupes.');
    }
  }

  Future<void> _fetchAgencies(int groupId) async {
    final response = await http.get(Uri.parse('http://'+ dotenv.get('LOCALIP') +':8080/api/agencies?groupId=$groupId'));
    if (response.statusCode == 200) {
      setState(() {
        _agences = List<Map<String, dynamic>>.from(jsonDecode(response.body));
        _selectedAgenceId = null;
      });
    } else {
      _showErrorSnackBar('Erreur lors du chargement des agences.');
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  List<DropdownMenuItem<int>> _buildDropdownItems(List<Map<String, dynamic>> items) {
    return items.map((item) => DropdownMenuItem<int>(
      value: item['id'],
      child: Text(item['name'], style: const TextStyle(fontSize: 16.0, color: attijariTextSecondary)),
    )).toList();
  }

  Widget _buildDropdown({
    required String label,
    required int? value,
    required List<Map<String, dynamic>> items,
    required Function(int?) onChanged,
  }) {
    return DropdownButtonFormField<int>(
      isExpanded: true,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: attijariPrimary, width: 1.5)),
        enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey)),
        filled: true,
        fillColor: attijariWhite,
      ),
      dropdownColor: attijariWhite,
      style: const TextStyle(fontSize: 16.0, color: attijariTextPrimary),
      value: value,
      items: _buildDropdownItems(items),
      onChanged: onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: attijariPrimary,
        title: const Text('Détails de la visite', style: TextStyle(color: attijariWhite, fontWeight: FontWeight.bold)),
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
            _buildDropdown(
              label: 'Région',
              value: _selectedRegionId,
              items: _regions,
              onChanged: (value) {
                setState(() {
                  _selectedRegionId = value;
                  _selectedGroupId = null;
                  _selectedAgenceId = null;
                  _groupes = [];
                  _agences = [];
                });
                if (value != null) _fetchGroups(value);
              },
            ),
            const SizedBox(height: 16.0),
            _buildDropdown(
              label: 'Groupe',
              value: _selectedGroupId,
              items: _groupes,
              onChanged: (value) {
                setState(() {
                  _selectedGroupId = value;
                  _selectedAgenceId = null;
                  _agences = [];
                });
                if (value != null) _fetchAgencies(value);
              },
            ),
            const SizedBox(height: 16.0),
            _buildDropdown(
              label: 'Agence',
              value: _selectedAgenceId,
              items: _agences,
              onChanged: (value) {
                setState(() {
                  _selectedAgenceId = value;
                });
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
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
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
                          formId: 1,
                          regionId: _selectedRegionId!,
                          groupId: _selectedGroupId!,
                          agenceId: _selectedAgenceId!,
                          //regionName: selectedRegion['name'],
                          //groupName: selectedGroup['name'],
                          //agenceName: selectedAgence['name'],
                        ),
                      ),
                    );
                  } else {
                    _showErrorSnackBar("Veuillez sélectionner la région, le groupe et l'agence.");
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
