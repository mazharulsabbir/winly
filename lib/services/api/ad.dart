import 'dart:io';

import 'package:winly/globals/controllers/auth_controller.dart';
import 'package:winly/services/api/api_service.dart';

class AdAPI {
  static Future<dynamic> requestForTicket({
    required String adStatus,
  }) async {
    try {
      final AuthController authController = AuthController();
      final _response = await ApiService.post(
        'api/user-ad',
        token: authController.token,
        body: {
          'ad_status': adStatus,
        },
      );

      return Future.value(_response);
    } on SocketException catch (_) {
      return null;
    }
  }
}
