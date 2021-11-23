class AboutUs {
  String? id;
  String? title;
  String? details;
  String? createdAt;
  String? updatedAt;

  AboutUs({
    this.id,
    this.title,
    this.details,
    this.createdAt,
    this.updatedAt,
  });

  factory AboutUs.fromJson(Map<String, dynamic> json) => AboutUs(
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
    return 'AboutUs{id: $id, title: $title, details: $details, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
