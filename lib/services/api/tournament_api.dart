import 'package:winly/services/api/api_service.dart';

class TournamentAPI {
  static Future<dynamic> getTournaments(String? token) async {
    try {
      final _response = await ApiService.get("/tournaments");
      return Future.value(_response);
    } catch (e) {
      return Future.error(e);
    }
  }
}
