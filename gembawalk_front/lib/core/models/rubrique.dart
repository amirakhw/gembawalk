import 'package:gembawalk_front/core/models/checklist_item_reponse.dart';

import 'checklist_item.dart';
import 'question.dart';

class Rubrique {
  final int id;
  final String name;
  final String type; // 'CHECKLIST' or 'QUESTION'
  final int order;
  final List<ChecklistItem> checklistItems;
  final List<Question> questions;

  Rubrique({
    required this.id,
    required this.name,
    required this.type,
    required this.order,
    this.checklistItems = const [],
    this.questions = const [],
  });

  factory Rubrique.fromJson(Map<String, dynamic> json) {
    return Rubrique(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      order: json['order'],
      checklistItems:
          (json['checklistItems'] ?? [])
              .map<ChecklistItem>((c) => ChecklistItem.fromJson(c))
              .toList(),
      questions:
          (json['questions'] ?? [])
              .map<Question>((q) => Question.fromJson(q))
              .toList(),
    );
  }
  Rubrique copy() {
    return Rubrique(
      id: id,
      name: name,
      type: type,
      order: order,
      checklistItems: checklistItems.map((item) => item.copy()).toList(),
      questions: questions.map<Question>((q) => q.copy()).toList(),
    );
  }

  @override
  String toString() {
    /* return """ ** Rubrique: $name  id:$id
    type $type  - order $order
    *******************************************
    ${checklistItems.map((item) => item.toString() + "\n -------_____________-------- \n")}"""; */

    return """ ** Rubrique: $name  id:$id
    type $type  - order $order
    *******************************************- \n")}""";
  }
}
