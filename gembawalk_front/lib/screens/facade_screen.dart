import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'login_screen.dart';
import 'enseignes_lumineuses_screen.dart';

class FacadeScreen extends StatefulWidget {
  final Map<String, dynamic>? initialData;

  const FacadeScreen({super.key, this.initialData});

  @override
  State<FacadeScreen> createState() => _FacadeScreenState();
}

class _FacadeScreenState extends State<FacadeScreen> {
  Map<String, String?> _facadeConformity = {};
  Map<String, String> _ticketNumbers = {};
  Map<String, List<XFile>> _itemImages = {};
  Map<String, String> _comments = {};

  final Map<String, TextEditingController> _ticketControllers = {};
  final Map<String, TextEditingController> _commentControllers = {};

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    final initial = widget.initialData ?? {};

    _facadeConformity = Map<String, String?>.from(
      initial['conformity'] ??
          {
            'Habillage GAB': null,
            'Revêtement Marbre': null,
            'Drapeau': null,
            'Portes affiches façade': null,
            'TOTEM Horaire': null,
            'Porte d\'entrée principale': null,
          },
    );

    _ticketNumbers = Map<String, String>.from(
      initial['ticketNumbers'] ??
          {
            'Habillage GAB': '',
            'Revêtement Marbre': '',
            'Drapeau': '',
            'Portes affiches façade': '',
            'TOTEM Horaire': '',
            'Porte d\'entrée principale': '',
          },
    );

    _comments = Map<String, String>.from(
      initial['comments'] ??
          {
            'Habillage GAB': '',
            'Revêtement Marbre': '',
            'Drapeau': '',
            'Portes affiches façade': '',
            'TOTEM Horaire': '',
            'Porte d\'entrée principale': '',
          },
    );

    // Safely converting images list from dynamic to List<XFile>
    _itemImages =
        (initial['images'] is Map)
            ? Map<String, List<XFile>>.from(
              (initial['images'] as Map<String, dynamic>)
                  .map<String, List<XFile>>((key, value) {
                    var list = (value is List) ? value : [];
                    return MapEntry(
                      key,
                      list
                          .where((element) => element != null)
                          .map<XFile>((e) => XFile(e.toString()))
                          .toList(),
                    );
                  }),
            )
            : {
              'Habillage GAB': [],
              'Revêtement Marbre': [],
              'Drapeau': [],
              'Portes affiches façade': [],
              'TOTEM Horaire': [],
              'Porte d\'entrée principale': [],
            };

    _facadeConformity.keys.forEach((key) {
      _ticketControllers[key] = TextEditingController(
        text: _ticketNumbers[key] ?? '',
      );
      _commentControllers[key] = TextEditingController(
        text: _comments[key] ?? '',
      );
    });
  }

  void _updateConformity(String item, String? value) {
    setState(() {
      _facadeConformity[item] = value;
      if (value == 'conforme') {
        _ticketControllers[item]?.text = '';
        _ticketNumbers[item] = '';
      }
    });
  }

  void _updateTicketNumber(String item, String value) {
    _ticketNumbers[item] = value;
  }

  void _updateComment(String item, String value) {
    _comments[item] = value;
  }

  Future<void> _takePicture(String item) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _itemImages[item] = [...?_itemImages[item], image];
        print('Image captured for $item: ${image.path}');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: attijariPrimary,
        title: const Text(
          '1. Façade',
          style: TextStyle(color: attijariWhite, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: attijariWhite),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
              _facadeConformity.keys.map((item) {
                  return _buildFacadeItem(item);
                }).toList()
                ..addAll([
                  const SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: attijariPrimary),
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          onPressed: () {
                            final facadeData = {
                              'conformity': _facadeConformity,
                              'ticketNumbers': _ticketNumbers,
                              'comments': _comments,
                              'images': _itemImages.map(
                                (key, value) => MapEntry(
                                  key,
                                  value.map((file) => file.path).toList(),
                                ),
                              ),
                            };
                            Navigator.pop(context, facadeData);
                          },
                          child: const Text(
                            'Valider et Retourner',
                            style: TextStyle(
                              color: attijariPrimary,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: attijariPrimary,
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        const EnseignesLumineusesScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Suivant',
                            style: TextStyle(
                              color: attijariWhite,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
        ),
      ),
    );
  }

  Widget _buildFacadeItem(String item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            item,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: attijariTextPrimary,
            ),
          ),
          const SizedBox(height: 8.0),
          Row(
            children: <Widget>[
              Radio<String>(
                value: 'conforme',
                groupValue: _facadeConformity[item],
                onChanged: (String? value) {
                  _updateConformity(item, value);
                },
                activeColor: attijariSuccess,
              ),
              const Text('Conforme', style: TextStyle(color: attijariSuccess)),
              const SizedBox(width: 16.0),
              Radio<String>(
                value: 'non conforme',
                groupValue: _facadeConformity[item],
                onChanged: (String? value) {
                  _updateConformity(item, value);
                },
                activeColor: attijariError,
              ),
              const Text(
                'Non Conforme',
                style: TextStyle(color: attijariError),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.camera_alt),
                onPressed: () => _takePicture(item),
              ),
            ],
          ),
          if (_facadeConformity[item] == 'non conforme')
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                controller: _ticketControllers[item],
                decoration: const InputDecoration(
                  labelText: 'Numéro de Ticket',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => _updateTicketNumber(item, value),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: TextField(
              controller: _commentControllers[item],
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'Commentaires (Optionnel)',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => _updateComment(item, value),
            ),
          ),
          if (_itemImages[item]?.isNotEmpty == true)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SizedBox(
                height: 100,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _itemImages[item]!.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final image = _itemImages[item]![index];
                    return Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            File(image.path),
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _itemImages[item]!.removeAt(index);
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(4),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),

          const Divider(),
        ],
      ),
    );
  }
}
