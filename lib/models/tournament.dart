class Tournaments {
  List<Tournament>? tournaments;

  Tournaments({required this.tournaments});

  Tournaments.fromJson(dynamic json) {
    if (json != null) {
      tournaments = [];
      json.forEach((v) {
        tournaments?.add(Tournament.fromJson(v));
      });
    }
  }

  List<Map<String, dynamic>>? toJson() {
    List<Map<String, dynamic>>? data = [<String, dynamic>{}];
    if (tournaments != null) {
      data = tournaments?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tournament {
  final int id;
  final String title;
  final String description;
  final String rules;
  final String banner_img;
  final String game_name;
  final String total_seats;
  final String require_tickets;
  final String status;
  final String deadline;
  final String created_at;
  final String updated_at;

  Tournament({
    required this.id,
    required this.title,
    required this.description,
    required this.rules,
    required this.banner_img,
    required this.game_name,
    required this.total_seats,
    required this.require_tickets,
    required this.status,
    required this.deadline,
    required this.created_at,
    required this.updated_at,
  });

  factory Tournament.fromJson(Map<String, dynamic> json) {
    return Tournament(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      rules: json['rules'],
      banner_img: json['banner_img'],
      game_name: json['game_name'],
      total_seats: json['total_seats'],
      require_tickets: json['require_tickets'],
      status: json['status'],
      deadline: json['deadline'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'rules': rules,
      'banner_img': banner_img,
      'game_name': game_name,
      'total_seats': total_seats,
      'require_tickets': require_tickets,
      'status': status,
      'deadline': deadline,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }

  @override
  String toString() {
    return 'Tournament{id: $id, title: $title, description: $description, rules: $rules, banner_img: $banner_img, game_name: $game_name, total_seats: $total_seats, require_tickets: $require_tickets, status: $status, deadline: $deadline, created_at: $created_at, updated_at: $updated_at}';
  }
}
