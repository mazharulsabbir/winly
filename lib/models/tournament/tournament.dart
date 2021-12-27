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
  int? id;
  String? title;
  String? description;
  String? rules;
  String? points;
  String? bannerImg;
  String? gameName;
  String? gameType;
  String? totalSeats;
  String? requireTickets;
  String? status;
  String? deadline;
  String? createdAt;
  String? updatedAt;
  int? players;
  List<ProfileImage>? photos;
  List<Positions>? positions;
  int? field;
  bool? joinStatus;

  Tournament({
    required this.id,
    required this.title,
    required this.description,
    required this.rules,
    required this.points,
    required this.bannerImg,
    required this.gameName,
    required this.gameType,
    required this.totalSeats,
    required this.requireTickets,
    required this.status,
    required this.deadline,
    required this.createdAt,
    required this.updatedAt,
    required this.players,
    required this.photos,
    required this.positions,
    required this.field,
    required this.joinStatus,
  });

  Tournament.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    rules = json['rules'];
    points = json['points'];
    bannerImg = json['banner_img'];
    gameName = json['game_name'];
    gameType = json['game_type'];
    totalSeats = json['total_seats'];
    requireTickets = json['require_tickets'];
    status = json['status'];
    deadline = json['deadline'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    players = json['players'];
    photos = [];
    if (json['photos'] != null) {
      json['photos'].forEach((v) {
        photos?.add(ProfileImage.fromJson(v));
      });
    }
    positions = [];
    if (json['positions'] != null) {
      json['positions'].forEach((v) {
        positions?.add(Positions.fromJson(v));
      });
    }
    field = json['field'];
    joinStatus = json['join_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['rules'] = rules;
    data['points'] = points;
    data['banner_img'] = bannerImg;
    data['game_name'] = gameName;
    data['game_type'] = gameType;
    data['total_seats'] = totalSeats;
    data['require_tickets'] = requireTickets;
    data['status'] = status;
    data['deadline'] = deadline;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['players'] = players;
    if (photos != null) {
      data['photos'] = photos?.map((v) => v.toJson()).toList();
    }
    if (positions != null) {
      data['positions'] = positions?.map((v) => v.toJson()).toList();
    }
    data['field'] = field;
    data['join_status'] = joinStatus;
    return data;
  }

  @override
  String toString() {
    return 'Tournament(id: $id, title: $title, description: $description, rules: $rules, points: $points, bannerImg: $bannerImg, gameName: $gameName, gameType: $gameType, totalSeats: $totalSeats, requireTickets: $requireTickets, status: $status, deadline: $deadline, createdAt: $createdAt, updatedAt: $updatedAt, players: $players, photos: $photos, positions: $positions, field: $field, joinStatus: $joinStatus)';
  }
}

class ProfileImage {
  String? profileImage;

  ProfileImage({required this.profileImage});

  ProfileImage.fromJson(dynamic json) {
    profileImage = json['profile_img'];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'profile_img': profileImage,
    };
  }

  @override
  String toString() {
    return 'ProfileImage {profile_img: $profileImage}';
  }
}

class Positions {
  final int? id;
  final String? tournamentId;
  final String? amount;
  final String? position;
  final String? createdAt;
  final String? updatedAt;

  Positions({
    this.id,
    this.tournamentId,
    this.amount,
    this.position,
    this.createdAt,
    this.updatedAt,
  });

  Positions.fromJson(dynamic json)
      : id = json['id'],
        tournamentId = json['tournament_id'],
        amount = json['amount'],
        position = json['position'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'tournament_id': tournamentId,
      'amount': amount,
      'position': position,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  @override
  String toString() {
    return 'Positions {id: $id, tournamentId: $tournamentId, amount: $amount, position: $position, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
