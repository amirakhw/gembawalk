import 'package:image_picker/image_picker.dart';

class ChecklistItem {
  final int id;
  final String name;
  final int order;
  final DateTime? created_at;
  String? comment;
  String? ticket_number;
  String? status; //CONFORM & NON CONFORM
  List<XFile>? images;

  ChecklistItem({
    required this.id,
    required this.name,
    required this.order,
    required this.created_at,
    required this.comment,
    required this.ticket_number,
    required this.status,
    required this.images,
  });

  factory ChecklistItem.fromJson(Map<String, dynamic> json) {
    return ChecklistItem(
      id: json['id'],
      name: json['name'],
      order: json['order'],
      created_at: json['created_at'],
      comment: json['commnent'],
      ticket_number: json['ticket_number'],
      status: json['status'],
      images: json['images'],
    );
  }

  ChecklistItem copy() {
    return ChecklistItem(
      id: id,
      name: name,
      order: order,
      created_at:
          created_at == null
              ? null
              : DateTime.fromMillisecondsSinceEpoch(
                created_at!.millisecondsSinceEpoch,
              ),
      comment: comment,
      ticket_number: ticket_number,
      status: status,
      images: images,
    );
  }

  @override
  String toString() {
    return "item_id: $id \n item_name: $name \n item_comment: $comment \n item_ticket_num: $ticket_number \n item_status: $status\n item_images: $images";
  }
}
