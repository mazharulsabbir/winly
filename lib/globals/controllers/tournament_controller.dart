import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as getx;
import 'package:winly/models/tournament.dart';
import 'package:winly/services/api/tournament_api.dart';
import 'package:winly/services/db/auth.dart';

class TournamentController extends getx.GetxController {
  String? token;
  bool isLoading = false;
  List<Tournament>? tournaments = [];

  TournamentController() {
    token = AuthDBService.getToken();
    getTournaments();
  }

  Future<dynamic> getTournaments() async {
    isLoading = true;
    update();

    try {
      dynamic _response = await TournamentAPI.getTournaments(token);
      tournaments = Tournaments.fromJson(
        _response.data,
      ).tournaments;
    } catch (e) {
      debugPrint(e.toString());
    }

    isLoading = false;
    update();
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

      return _response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
