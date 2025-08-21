//import 'agence.dart';
import 'rubrique.dart';

class VisitHistoryModel {
  final int id;
  final int agence_id;
  final String agence_name;
  //final String email;
  //final AgenceModel? agency;
  final DateTime created_at;
  final List<Rubrique> rubriques;

  VisitHistoryModel({
    required this.id,
    required this.agence_id,

    required this.agence_name,
    //required this.email,
    required this.created_at,
    this.rubriques = const [],
  });

  factory VisitHistoryModel.fromJson(Map<String, dynamic> json) {
    return VisitHistoryModel(
      id: json['id'],
      agence_id: json["agence"]["id"],
      created_at: DateTime.parse(json['createdAt']),
      agence_name:
          "${json['agence']["name"]}, ${json['agence']["group"]["name"]}, ${json['agence']["group"]["region"]["name"]}",
    );
  }

  Map<String, dynamic> toJson({
    required int formId,
    required int userId,
    List<Map<String, dynamic>> questionResponses = const [],
  }) {
    final checklistResponses = <Map<String, dynamic>>[];

    for (var rubrique in rubriques) {
      if (rubrique.type == 'CHECKLIST') {
        for (var item in rubrique.checklistItems) {
          if (item.status != null) {
            checklistResponses.add({
              'rubriqueId': rubrique.id,
              'itemId': item.id,
              'status': item.status,
              'ticketNumber': item.ticket_number,
              'comment': item.comment,
              'photoUrl': 0, // or item.photoUrl if implemented
            });
          }
        }
      }
    }

    return {
      'formId': formId,
      'userId': userId,
      'agenceId': agence_id,
      'checklistResponses': checklistResponses,
      'questionResponses': questionResponses,
    };
  }

  @override
  String toString() {
    return """"visit id $id -- date $created_at \n agence id: $agence_id \n
    ***********************************
    ${rubriques.map((r) => r.toString() + "\n ************************* \n")}""";
  }
}
