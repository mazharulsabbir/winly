class PrivacyPolicy {
  String? id;
  String? title;
  String? details;
  String? createdAt;
  String? updatedAt;

  PrivacyPolicy({
    this.id,
    this.title,
    this.details,
    this.createdAt,
    this.updatedAt,
  });

  factory PrivacyPolicy.fromJson(Map<String, dynamic> json) => PrivacyPolicy(
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
    return 'PrivacyPolicy{id: $id, title: $title, details: $details, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
