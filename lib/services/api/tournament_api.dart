import 'package:winly/services/api/api_service.dart';

class TournamentAPI {
  static Future<dynamic> getTournaments(String? token) async {
    try {
      final _response = await ApiService.get("api/tournaments", token: token);
      return Future.value(_response);
    } catch (e) {
      return Future.error(e);
    }
  }
}
