class Notices {
  List<Notice>? notices;

  Notices({this.notices});

  Notices.fromJson(Map<String, dynamic> json) {
    if (json['all_notice'] != null) {
      notices = [];
      json['all_notice'].forEach((v) {
        notices?.add(Notice.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (notices != null) {
      data['all_notice'] = notices?.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'Notices{notices: $notices}';
  }
}

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
      details: json["details"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "details": details,
        "created_at": createdAt,
        "updated_at": updatedAt
      };

  @override
  String toString() {
    return 'Notice{id: $id, title: $title, details: $details, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
