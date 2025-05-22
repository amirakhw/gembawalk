import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ChecklistItemWidget extends StatelessWidget {
  final String itemName;
  final String? conformity;
  final TextEditingController ticketController;
  final TextEditingController commentController;
  final List<XFile> images;
  final Function(String?) onConformityChanged;
  final Function(String) onTicketChanged;
  final Function(String) onCommentChanged;
  final Function() onAddImage;
  final Function(int) onRemoveImage;

  const ChecklistItemWidget({
    super.key,
    required this.itemName,
    required this.conformity,
    required this.ticketController,
    required this.commentController,
    required this.images,
    required this.onConformityChanged,
    required this.onTicketChanged,
    required this.onCommentChanged,
    required this.onAddImage,
    required this.onRemoveImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          itemName,
          style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Radio<String>(
              value: 'CONFORM',
              groupValue: conformity,
              onChanged: (value) {
                onConformityChanged(value);
              },
            ),

            const Text('Conforme'),
            Radio<String>(
              value: 'NON_CONFORM',
              groupValue: conformity,
              onChanged: onConformityChanged,
            ),
            const Text('Non Conforme'),
            IconButton(
              icon: const Icon(Icons.camera_alt),
              onPressed: onAddImage,
            ),
          ],
        ),
        if (conformity == 'NON_CONFORM')
          TextField(
            controller: ticketController,
            decoration: const InputDecoration(labelText: 'Numéro de Ticket'),
            onChanged: onTicketChanged,
          ),
        TextField(
          controller: commentController,
          decoration: const InputDecoration(labelText: 'Commentaires'),
          onChanged: onCommentChanged,
        ),
        if (images.isNotEmpty)
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Image.file(
                      File(images[index].path),
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      right: 0,
                      child: GestureDetector(
                        onTap: () => onRemoveImage(index),
                        child: const Icon(Icons.close, color: Colors.red),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        const Divider(),
      ],
    );
  }
}
