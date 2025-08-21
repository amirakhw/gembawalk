import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/rubrique.dart';
import '../models/checklist_item.dart';
import 'checklist_item_widget.dart';
import 'package:gembawalk_front/config/colors.dart';

class ChecklistScreen extends StatefulWidget {
  final String title;
  final Map<String, dynamic>? initialData;
  final Function(Map<String, dynamic>) onSaveData;
  final Widget? nextScreen;
  final Rubrique rubrique;

  const ChecklistScreen({
    super.key,
    required this.title,
    this.initialData,
    required this.onSaveData,
    this.nextScreen,
    required this.rubrique,
  });

  @override
  _ChecklistScreenState createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  late Map<int, String?> conformity;
  late Map<int, TextEditingController> ticketControllers;
  late Map<int, TextEditingController> commentControllers;
  late Map<int, List<XFile>> images;
  //File? _selectedImage;
  @override
  void initState() {
    super.initState();
    conformity = {};
    ticketControllers = {};
    commentControllers = {};
    images = {};

    for (var item in widget.rubrique.checklistItems) {
      conformity[item.id] =
          widget.initialData?['conformity']?['item_${item.id}'] as String?;
      ticketControllers[item.id] = TextEditingController(
        text: widget.initialData?['ticketNumbers']?['item_${item.id}'] ?? '',
      );
      commentControllers[item.id] = TextEditingController(
        text: widget.initialData?['comments']?['item_${item.id}'] ?? '',
      );
      images[item.id] = widget.initialData?['images']?['item_${item.id}'] ?? [];
    }

    //getLostData();
  }

  /*void _handleLostFiles(List<XFile> files) {
    setState(() {
      _imageFile = files.first; // ou plusieurs selon ton besoin
    });
  }

  void _handleError(Exception? e) {
    debugPrint("Erreur lors de la récupération de l’image : $e");
  }

  Future<void> getLostData() async {
    final ImagePicker picker =
        ImagePicker(); //On instancie l’outil qui va gérer les images
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) return;

    if (response.files != null) {
      _handleLostFiles(response.files!);
    } else {
      _handleError(response.exception);
    }
  }
*/

  @override
  void dispose() {
    for (var c in ticketControllers.values) {
      c.dispose();
    }
    for (var c in commentControllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  Map<String, dynamic> _collectData() => {
    'conformity': {
      for (var entry in conformity.entries) 'item_${entry.key}': entry.value,
    },
    'ticketNumbers': {
      for (var entry in ticketControllers.entries)
        'item_${entry.key}': entry.value.text,
    },
    'comments': {
      for (var entry in commentControllers.entries)
        'item_${entry.key}': entry.value.text,
    },
    'images': {
      for (var entry in images.entries)
        //'item_${entry.key}': entry.value.map((e) => e.path).toList(),
        'item_${entry.key}': entry.value.toList(),
    },
  };

  void _autoSave() {
    widget.onSaveData(_collectData());
  }

  void _returnToMenu() {
    _autoSave();
    Navigator.of(context).pop();
  }

  void _goNext() {
    _autoSave();
    if (widget.nextScreen != null) {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => widget.nextScreen!));
    }
  }

  Future<void> _pickImageFromCamera(int itemId) async {
    final returnedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (returnedImage == null) return;

    setState(() {
      images[itemId]?.add(returnedImage);
    });

    _autoSave();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          widget.title,
          style: const TextStyle(color: AppColors.white),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: widget.rubrique.checklistItems.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = widget.rubrique.checklistItems[index];
                return ChecklistItemWidget(
                  itemName: item.name,
                  conformity: conformity[item.id],
                  ticketController: ticketControllers[item.id]!,
                  commentController: commentControllers[item.id]!,
                  onConformityChanged: (v) {
                    setState(() => conformity[item.id] = v);
                    _autoSave();
                  },
                  onTicketChanged: (v) {
                    setState(() {});
                    _autoSave();
                  },
                  onCommentChanged: (v) {
                    setState(() {});
                    _autoSave();
                  },
                  onCameraPressed: () {
                    _pickImageFromCamera(item.id);
                  },
                  images: images[item.id],
                );
              },
            ),
          ),
          SafeArea(
            top: false,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _returnToMenu,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.primary),
                        foregroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text('Retourner au Menu'),
                    ),
                  ),
                  if (widget.nextScreen != null) ...[
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _goNext,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text(
                          'Suivant',
                          style: TextStyle(color: AppColors.white),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
