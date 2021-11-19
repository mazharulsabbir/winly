class QuizzQuestion {
  int? id;
  String? question;
  List<String>? answers;
  String? correctAnswer;

  QuizzQuestion({this.id, this.question, this.answers, this.correctAnswer});

  factory QuizzQuestion.fromJson(Map<String, dynamic> json) {
    return QuizzQuestion(
      id: json['id'],
      question: json['question'],
      answers: json['answers'].cast<String>(),
      correctAnswer: json['correctAnswer'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'answers': answers,
      'correctAnswer': correctAnswer,
    };
  }

  @override
  String toString() {
    return 'QuizzQuestion{id: $id, question: $question, answers: $answers, correctAnswer: $correctAnswer}';
  }
}
