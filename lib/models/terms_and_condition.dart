class TermsAndCondition {
  String? id;
  String? title;
  String? details;
  String? createdAt;
  String? updatedAt;

  TermsAndCondition({
    this.id,
    this.title,
    this.details,
    this.createdAt,
    this.updatedAt,
  });

  factory TermsAndCondition.fromJson(Map<String, dynamic> json) =>
      TermsAndCondition(
        id: json["id"],
        title: json["title"],
        details: json["details"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "details": details,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };

  @override
  String toString() {
    return 'TermsAndCondition{id: $id, title: $title, details: $details, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
