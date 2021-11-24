class Notice {
  int? id;
  String? title;
  String? details;
  String? createdAt;
  String? updatedAt;

  Notice({this.id, this.title, this.details, this.createdAt, this.updatedAt});

  factory Notice.fromJson(Map<String, dynamic> json) => Notice(
      id: json["id"],
      title: json["title"],
      details: json["notice"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "notice": details,
        "created_at": createdAt,
        "updated_at": updatedAt
      };

  @override
  String toString() {
    return 'Notice{id: $id, title: $title, details: $details, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
