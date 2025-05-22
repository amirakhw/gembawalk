class ChecklistItemReponseModel {
  final int id;
  final int item_id;
  final String item_name;
  final int rubrique_id;
  final String rubrique_name;
  String? comment;
  String? ticket_number;
  String? status; //CONFORM & NON CONFORM

  ChecklistItemReponseModel({
    required this.id,
    required this.item_id,
    required this.item_name,
    required this.rubrique_id,
    required this.rubrique_name,
    required this.comment,
    required this.ticket_number,
    required this.status,
  });

  factory ChecklistItemReponseModel.fromJson(Map<String, dynamic> json) {
    return ChecklistItemReponseModel(
      id: json['id'],
      item_id: json['itemId'],
      item_name: json['itemName'],
      rubrique_id: json['rubriqueId'],
      rubrique_name: json['rubriqueName'],
      comment: json['commnent'],
      ticket_number: json['ticketNumber'],
      status: json['status'],
    );
  }

  /* ChecklistItemReponse copy() {
    return ChecklistItemReponse(
      id: id,
      name: name,
      order: order,
      // Reinstantiate the DateTime to avoid shared references
      created_at:
          created_at == null
              ? null
              : DateTime.fromMillisecondsSinceEpoch(
                created_at!.millisecondsSinceEpoch,
              ),
      comment: comment,
      ticket_number: ticket_number,
      status: status,
    );
  } */

  /* String toString() {
    return "item_id: $id \n item_name: $name \n item_comment: $comment \n item_ticket_num: $ticket_number \n item_status: $status";
  } */
}
