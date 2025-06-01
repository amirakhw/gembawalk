import 'checklist_item_reponse.dart';
import 'rubrique.dart';

class Visit {
  final int id;
  final int agence_id;
  final DateTime? created_at;
  final List<Rubrique> rubriques;

  Visit({
    required this.id,
    required this.agence_id,
    required this.created_at,
    this.rubriques = const [],
  });

  factory Visit.fromJson(Map<String, dynamic> json) {
    return Visit(
      id: json['id'] as int,
      agence_id:
          json['agence'] != null && json['agence']['id'] != null
              ? json['agence']['id'] as int
              : 0,
      created_at:
          json['createdAt'] == null ? null : DateTime.parse(json['createdAt']),
      rubriques:
          (json['rubriques'] as List<dynamic>?)
              ?.map((r) => Rubrique.fromJson(r as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson({required int formId, required int userId}) {
    final checklistResponses = <Map<String, dynamic>>[];
    final questionResponses = <Map<String, dynamic>>[];

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
              'photoUrl': 0, // Update if you add photo url support
            });
          }
        }
      } else if (rubrique.type == "QUESTIONS") {
        for (var item in rubrique.questions) {
          if (item.responseText?.trim().isNotEmpty ?? false) {
            questionResponses.add({
              'rubriqueId': rubrique.id,
              'questionId': item.id,
              'responseText': item.responseText,
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
    return """
visit id $id -- date $created_at 
agence id: $agence_id 
***********************************
${rubriques.map((r) => r.toString() + "\n************************* \n").join()}
""";
  }
}






















/* //import 'agence.dart';
import 'checklist_item_reponse.dart';
import 'rubrique.dart';

class Visit {
  final int id;
  final int agence_id;
  //final String? agence_name;
  //final String email;
  //final AgenceModel? agency;
  final DateTime? created_at;
  //final List<Rubrique> rubriques;
  final List<ChecklistItemReponseModel> rubriques;

  Visit({
    required this.id,
    required this.agence_id,

    //this.agence_name,
    //required this.email,
    required this.created_at,
    this.rubriques = const [],
  });

  factory Visit.fromJson(Map<String, dynamic> json) {
    return Visit(
      id: json['id'],
      agence_id: json["agence"]["id"],
      created_at:
          json['createdAt'] == null ? null : DateTime.parse(json['createdAt']),
      rubriques:
          (json['rubriques'] as List<dynamic>?)
              ?.map((r) => Rubrique.fromJson(r))
              .toList() ??
          [],
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
 */