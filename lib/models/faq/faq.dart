class FaqItem {
  final FaqType type;
  final dynamic item;

  FaqItem({required this.type, required this.item});

  @override
  String toString() {
    return 'FaqItem{type: $type, item: $item}';
  }
}

enum FaqType { youtube, other }

class FrequentlyAskedQuestion {
  final int? id;
  final String? question;
  final String? ans;
  final String? createdAt;
  final String? updatedAt;

  FrequentlyAskedQuestion({
    this.id,
    this.question,
    this.ans,
    this.createdAt,
    this.updatedAt,
  });

  factory FrequentlyAskedQuestion.fromJson(Map<String, dynamic> json) =>
      FrequentlyAskedQuestion(
        id: json.containsKey('id') ? json['id'] as int : null,
        question:
            json.containsKey('question') ? json['question'] as String : null,
        ans: json.containsKey('ans') ? json['ans'] as String : null,
        createdAt: json.containsKey('created_at')
            ? json['created_at'] as String
            : null,
        updatedAt: json.containsKey('updated_at')
            ? json['updated_at'] as String
            : null,
      );

  @override
  String toString() {
    return 'FrequentlyAskedQuestion[id=$id, question=$question, ans=$ans, createdAt=$createdAt, updatedAt=$updatedAt, ]';
  }
}
