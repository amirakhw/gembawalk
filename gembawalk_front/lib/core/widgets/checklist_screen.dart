// lib/core/widgets/checklist_screen.dart

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/rubrique.dart';
import '../models/checklist_item.dart'; // Import ChecklistItem model
import 'checklist_item_widget.dart';
import 'package:gembawalk_front/config/colors.dart';

class ChecklistScreen extends StatefulWidget {
  final String title;
  // Removed: final List<String> items;
  final Map<String, dynamic>? initialData;
  final Function(Map<String, dynamic>) onSaveData;
  final Widget? nextScreen;
  final Rubrique rubrique;

  const ChecklistScreen({
    super.key,
    required this.title,
    // Removed: required this.items,
    this.initialData,
    required this.onSaveData,
    this.nextScreen,
    required this.rubrique,
  });

  @override
  _ChecklistScreenState createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  late Map<int, String?> conformity; // Keyed by ChecklistItem ID
  late Map<int, TextEditingController> ticketControllers; // Keyed by ChecklistItem ID
  late Map<int, TextEditingController> commentControllers; // Keyed by ChecklistItem ID
  late Map<int, List<XFile>> images; // Keyed by ChecklistItem ID
  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    conformity = {};
    ticketControllers = {};
    commentControllers = {};
    images = {};

    for (var item in widget.rubrique.checklistItems) {
      conformity[item.id] = widget.initialData?['conformity']?['item_${item.id}'] as String?;
      ticketControllers[item.id] = TextEditingController(
        text: widget.initialData?['ticketNumbers']?['item_${item.id}'] ?? '',
      );
      commentControllers[item.id] = TextEditingController(
        text: widget.initialData?['comments']?['item_${item.id}'] ?? '',
      );
      images[item.id] = [];
    }
  }

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
          for (var entry in conformity.entries) 'item_${entry.key}': entry.value
        },
        'ticketNumbers': {
          for (var entry in ticketControllers.entries) 'item_${entry.key}': entry.value.text
        },
        'comments': {
          for (var entry in commentControllers.entries) 'item_${entry.key}': entry.value.text
        },
        'images': {
          for (var entry in images.entries)
            'item_${entry.key}': entry.value.map((e) => e.path).toList()
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
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => widget.nextScreen!),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          title: Text(widget.title,
              style: const TextStyle(color: AppColors.white)),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: widget.rubrique.checklistItems.map((item) {
                  return ChecklistItemWidget(
                    itemName: item.name,
                    conformity: conformity[item.id],
                    ticketController: ticketControllers[item.id]!,
                    commentController: commentControllers[item.id]!,
                    images: images[item.id]!,
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
                    onAddImage: () async {
                      final img =
                          await _picker.pickImage(source: ImageSource.camera);
                      if (img != null) {
                        setState(() => images[item.id]!.add(img));
                        _autoSave();
                      }
                    },
                    onRemoveImage: (i) {
                      setState(() => images[item.id]!.removeAt(i));
                      _autoSave();
                    },
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom + 16,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _returnToMenu,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.primary),
                        foregroundColor: AppColors.primary,
                      ),
                      child: const Text('Retourner au Menu'),
                    ),
                  ),
                  if (widget.nextScreen != null) ...[
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _goNext,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                        ),
                        child: const Text('Suivant',
                            style: TextStyle(color: AppColors.white)),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}