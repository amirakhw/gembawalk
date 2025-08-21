import 'rubrique.dart';

class FormModel {
  final int id;
  final String name;
  final String description;
  final List<Rubrique> rubriques;

  FormModel({
    required this.id,
    required this.name,
    required this.description,
    required this.rubriques,
  });

  factory FormModel.fromJson(Map<String, dynamic> json) {
    return FormModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      rubriques:
          (json['rubriques'] as List).map((r) => Rubrique.fromJson(r)).toList(),
    );
  }

  FormModel copy() {
    return FormModel(
      id: id,
      name: name,
      description: description,
      rubriques: rubriques.map((r) => r.copy()).toList(),
    );
  }

  List<Rubrique> copyRubriqueList() {
    return rubriques.map((r) => r.copy()).toList();
  }
}
