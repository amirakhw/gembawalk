import 'checklist_item_reponse.dart';
import 'rubrique.dart';

class PlanActionModel {
  final int id;
  final int agence_id;
  final String agence_name;
  //String email;
  //final DateTime? created_at;
  final List<ChecklistItemReponseModel> rubriques;
  bool? active;

  PlanActionModel({
    required this.id,
    required this.agence_id,
    required this.agence_name,
    //required this.email,
    //required this.created_at,
    this.rubriques = const [],
    this.active,
  });

  factory PlanActionModel.fromJson(Map<String, dynamic> json) {
    return PlanActionModel(
      id: json['id'],
      agence_id: json["agence"]["id"],
      agence_name:
          "${json['agence']["name"]}, ${json['agence']["group"]["name"]}, ${json['agence']["group"]["region"]["name"]}",
      active: json["active"],
    );
  }

  @override
  String toString() {
    return """"Plan Action id $id -- date \n agence id: $agence_id \n
    ***********************************
    ${rubriques.map((r) => r.toString() + "\n ************************* \n")}""";
  }
}
