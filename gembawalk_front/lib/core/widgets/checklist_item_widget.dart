import 'package:flutter/material.dart';
import 'package:gembawalk_front/config/colors.dart'; // Make sure AppColors is used

class ChecklistItemWidget extends StatelessWidget {
  final String itemName;
  final String? conformity;
  final TextEditingController ticketController;
  final TextEditingController commentController;
  final Function(String?) onConformityChanged;
  final Function(String) onTicketChanged;
  final Function(String) onCommentChanged;

  const ChecklistItemWidget({
    super.key,
    required this.itemName,
    required this.conformity,
    required this.ticketController,
    required this.commentController,
    required this.onConformityChanged,
    required this.onTicketChanged,
    required this.onCommentChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: AppColors.primary.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            itemName,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              ChoiceChip(
                label: const Text('Conforme'),
                selected: conformity == 'CONFORM',
                selectedColor: AppColors.primary,
                onSelected: (_) => onConformityChanged('CONFORM'),
                labelStyle: TextStyle(
                  color:
                      conformity == 'CONFORM'
                          ? Colors.white
                          : AppColors.primary,
                ),
                backgroundColor: AppColors.primary.withOpacity(0.1),
              ),
              const SizedBox(width: 12),
              ChoiceChip(
                label: const Text('Non Conforme'),
                selected: conformity == 'NON_CONFORM',
                selectedColor: Colors.redAccent,
                onSelected: (_) => onConformityChanged('NON_CONFORM'),
                labelStyle: TextStyle(
                  color:
                      conformity == 'NON_CONFORM'
                          ? Colors.white
                          : Colors.redAccent,
                ),
                backgroundColor: Colors.redAccent.withOpacity(0.1),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (conformity == 'NON_CONFORM')
            TextField(
              controller: ticketController,
              onChanged: onTicketChanged,
              decoration: InputDecoration(
                labelText: 'Numéro de Ticket',
                filled: true,
                fillColor: AppColors.primary.withOpacity(0.05),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          if (conformity == 'NON_CONFORM') const SizedBox(height: 12),
          TextField(
            controller: commentController,
            onChanged: onCommentChanged,
            decoration: InputDecoration(
              labelText: 'Commentaires',
              filled: true,
              fillColor: AppColors.primary.withOpacity(0.05),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
