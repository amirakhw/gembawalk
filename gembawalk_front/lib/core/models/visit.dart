import 'rubrique.dart';

class Visit {
  final int id;
  final int agence_id;
  final String agence_name;
  //final String email;
  final DateTime? created_at;
  final List<Rubrique> rubriques;

  Visit({
    required this.id,
    required this.agence_id,
    required this.agence_name,
    //required this.email,
    required this.created_at,
    this.rubriques = const [],
  });

  @override
  String toString() {
    return """"visit id $id -- date $created_at \n agence id: $agence_id \n
    ***********************************
    ${rubriques.map((r) => r.toString() + "\n ************************* \n")}""";
  }
}
