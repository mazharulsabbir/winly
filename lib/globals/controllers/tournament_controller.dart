import 'package:get/get.dart' as getx;
import 'package:winly/services/api/tournament_api.dart';
import 'package:winly/services/db/auth.dart';

class TournamentController extends getx.GetxController {
  String? token;
  bool isLoading = false;
  List<dynamic>? tournaments = [
    {"name": "abc"},
    {"name": "abc"},
    {"name": "abc"},
    {"name": "abc"}
  ];

  TournamentController() {
    token = AuthDBService.getToken();
    getTournaments();
  }

  Future<dynamic> getTournaments() async {
    // TournamentAPI.getTournaments(token).then((value) {
    //   tournaments = value;
    // });
  }
}
