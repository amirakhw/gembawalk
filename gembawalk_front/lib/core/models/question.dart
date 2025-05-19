class Question {
  final int id;
  final String questionText;
  final int order;

  Question({
    required this.id,
    required this.questionText,
    required this.order,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      questionText: json['questionText'],
      order: json['order'],
    );
  }
}
