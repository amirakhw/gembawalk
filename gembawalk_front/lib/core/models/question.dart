class Question {
  final int id;
  final String questionText;
  final int order;
  String? responseText;

  Question({
    required this.id,
    required this.questionText,
    required this.order,
    responseText,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      questionText: json['questionText'],
      order: json['order'],
    );
  }

  Question copy() {
    return Question(
      id: id,
      questionText: questionText,
      order: order,
      responseText: responseText,
    );
  }
}
