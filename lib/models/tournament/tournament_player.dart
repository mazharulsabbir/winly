class TournamentPlayer {
  String? id;
  String? tournamentId;
  String? userId;
  String? gameName;
  String? gameId;
  String? position;
  String? createdAt;
  String? updatedAt;
  String? name;

  TournamentPlayer({
    this.id,
    this.tournamentId,
    this.userId,
    this.gameName,
    this.gameId,
    this.position,
    this.createdAt,
    this.updatedAt,
    this.name,
  });

  factory TournamentPlayer.fromJson(Map<String, dynamic> json) =>
      TournamentPlayer(
        id: json["id"],
        tournamentId: json["tournament_id"],
        userId: json["user_id"],
        gameName: json["game_name"],
        gameId: json["game_id"],
        position: json["position"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tournament_id": tournamentId,
        "user_id": userId,
        "game_name": gameName,
        "game_id": gameId,
        "position": position,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "name": name,
      };

  TournamentPlayer copyWith({
    String? id,
    String? tournamentId,
    String? userId,
    String? gameName,
    String? gameId,
    String? position,
    String? createdAt,
    String? updatedAt,
    String? name,
  }) {
    return TournamentPlayer(
      id: id ?? this.id,
      tournamentId: tournamentId ?? this.tournamentId,
      userId: userId ?? this.userId,
      gameName: gameName ?? this.gameName,
      gameId: gameId ?? this.gameId,
      position: position ?? this.position,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      name: name ?? this.name,
    );
  }

  @override
  String toString() {
    return 'TournamentPlayer{id: $id, tournamentId: $tournamentId, userId: $userId, gameName: $gameName, gameId: $gameId, position: $position, createdAt: $createdAt, updatedAt: $updatedAt, name: $name}';
  }
}
