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
  final String points;
  final String bannerImg;
  final String gameName;
  final String totalSeats;
  final String requireTickets;
  final String status;
  final String deadline;
  final int players;
  final List<ProfileImage> photos;
  final String createdAt;
  final String updatedAt;

  Tournament({
    required this.id,
    required this.title,
    required this.description,
    required this.rules,
    required this.points,
    required this.bannerImg,
    required this.gameName,
    required this.totalSeats,
    required this.requireTickets,
    required this.status,
    required this.deadline,
    required this.players,
    required this.photos,
    required this.createdAt,
    required this.updatedAt,
  });

  Tournament.fromJson(dynamic json)
      : id = json['id'] as int,
        title = json['title'] as String,
        description = json['description'] as String,
        rules = json['rules'] as String,
        points = json['points'] as String,
        bannerImg = json['banner_img'] as String,
        gameName = json['game_name'] as String,
        totalSeats = json['total_seats'] as String,
        requireTickets = json['require_tickets'] as String,
        status = json['status'] as String,
        deadline = json['deadline'] as String,
        players = json['players'] as int,
        photos = (json['photos'] as List<dynamic>)
            .map((e) => ProfileImage.fromJson(e))
            .toList(),
        createdAt = json['created_at'] as String,
        updatedAt = json['updated_at'] as String;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'rules': rules,
      'points': points,
      'banner_img': bannerImg,
      'game_name': gameName,
      'total_seats': totalSeats,
      'require_tickets': requireTickets,
      'status': status,
      'deadline': deadline,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  @override
  String toString() {
    return 'Tournament {id: $id, title: $title, description: $description, rules: $rules, bannerImg: $bannerImg, gameName: $gameName, totalSeats: $totalSeats, requireTickets: $requireTickets, status: $status, deadline: $deadline, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}

class ProfileImage {
  String? profileImage;

  ProfileImage({required this.profileImage});

  ProfileImage.fromJson(dynamic json) {
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'profile_image': profileImage,
    };
  }

  @override
  String toString() {
    return 'ProfileImage {profileImage: $profileImage}';
  }
}
