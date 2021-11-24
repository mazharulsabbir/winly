import 'package:flutter/material.dart';
import 'package:winly/services/api/api_service.dart';

class TournamentAPI {
  static Future<dynamic> getTournaments(String? token) async {
    try {
      final _response = await ApiService.get("api/tournaments", token: token);
      return Future.value(_response);
    } catch (e) {
      debugPrint("======== Error Getting Tournamets ========");
      return Future.error(e);
    }
  }

  static Future<dynamic> joinTournament(
    dynamic tournamentId,
    dynamic gameName,
    dynamic gameIds,
    String? token,
  ) async {
    print("${{"game_name": gameName, "game_id": gameIds}}");
    try {
      final _response = await ApiService.post(
        "api/join-tournament/$tournamentId",
        body: {"game_name": gameName, "game_id": gameIds},
        token: token,
      );

      return Future.value(_response);
    } catch (e) {
      debugPrint("======== Error Getting Tournamets ========");
      return Future.error(e);
    }
  }
}
