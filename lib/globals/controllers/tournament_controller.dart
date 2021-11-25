import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as getx;
import 'package:winly/models/tournament/tournament.dart';
import 'package:winly/models/tournament/tournament_player.dart';
import 'package:winly/services/api/tournament_api.dart';
import 'package:winly/services/db/auth.dart';

class TournamentController extends getx.GetxController {
  String? token;
  bool isLoading = false;

  final _tournaments = [].obs;
  List<Tournament> get tournaments {
    return [..._tournaments];
  }

  final _tournamentPlayers = [].obs;
  List<TournamentPlayer> get tournamentPlayers {
    return [..._tournamentPlayers];
  }

  TournamentController() {
    token = AuthDBService.getToken();
    getTournaments();
  }

  Future<dynamic> getTournaments() async {
    debugPrint("=== Tournaments ===");
    isLoading = true;
    update();

    try {
      dynamic _response = await TournamentAPI.getTournaments(token);
      List<Tournament>? _t = Tournaments.fromJson(
        _response.data,
      ).tournaments;

      if (_t != null) {
        _tournaments.value = _t;
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    isLoading = false;
    update();
  }

  Future<dynamic> getTournamentPlayers(String tournamentId) async {
    debugPrint("=== Tournament Players ===");
    isLoading = true;
    update();

    try {
      final _response = await TournamentAPI.getTournamentPlayers(
        token,
        tournamentId,
      );

      List<dynamic>? _p = _response.data;

      if (_p != null) {
        _tournamentPlayers.value =
            _p.map((e) => TournamentPlayer.fromJson(e)).toList();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<dynamic> joinTournament(
    dynamic tournamentId,
    dynamic gameName,
    dynamic gameIds,
  ) async {
    try {
      dynamic _response = await TournamentAPI.joinTournament(
        tournamentId,
        gameName,
        gameIds,
        token,
      );

      // update tournament list with new tournament
      getTournaments();

      return _response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
