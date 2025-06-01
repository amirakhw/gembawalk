import 'package:flutter/material.dart';
import 'package:gembawalk_front/config/theme.dart';
import 'package:gembawalk_front/core/widgets/checklist_item_widget.dart'; // Import ChecklistItemWidget
import 'package:image_picker/image_picker.dart'; // Import XFile class

class VisiteDetailsScreen extends StatelessWidget {
  final String agencyName;
  final List<Map<String, dynamic>> rubriques;

  const VisiteDetailsScreen({
    super.key,
    required this.agencyName,
    required this.rubriques,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: attijariPrimary,
        title: Text(
          'Visite: $agencyName',
          style: const TextStyle(
            color: attijariWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: attijariWhite),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: rubriques.length,
          itemBuilder: (context, index) {
            final rubrique = rubriques[index];
            return Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 12.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      rubrique['title'],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: attijariTextPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Display checklist items using ChecklistItemWidget
                    ...(rubrique['conformity'] as Map<String, String>).keys.map((
                      key,
                    ) {
                      // Mock controllers,  images.  Real data is already in rubrique.
                      final ticketController = TextEditingController(
                        text: rubrique['ticketNumbers']?[key] ?? '',
                      );
                      final commentController = TextEditingController(
                        text: rubrique['comments']?[key] ?? '',
                      );
                      final List<XFile> mockImages = [];

                      return ChecklistItemWidget(
                        itemName: key,
                        conformity: rubrique['conformity'][key],
                        ticketController: ticketController,
                        commentController: commentController,
                        //images: mockImages, //  Use an empty list.
                        onConformityChanged:
                            (v) {}, //  These callbacks do nothing for display.
                        onTicketChanged: (v) {},
                        onCommentChanged: (v) {},
                        //onAddImage: () {},
                        //onRemoveImage: (i) {},
                      );
                    }),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
