class Notices {
  List<Notice>? notices;

  Notices({this.notices});

  Notices.fromJson(Map<String, dynamic> json) {
    if (json['all_notice'] != null) {
      notices = [];
      json['all_notice'].forEach((v) {
        notices?.add(new Notice.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notices != null) {
      data['all_notice'] = this.notices?.map((v) => v.toJson()).toList();
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
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        details: json["details"] == null ? null : json["details"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "details": details == null ? null : details,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
      };

  @override
  String toString() {
    return 'Notice{id: $id, title: $title, details: $details, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
