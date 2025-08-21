class AgenceModel {
  final int id;
  final String name;

  AgenceModel({required this.id, required this.name});

  factory AgenceModel.fromJson(Map<String, dynamic> json) {
    return AgenceModel(id: json['id'], name: json['name']);
  }
}
