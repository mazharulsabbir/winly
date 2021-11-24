import 'dart:io';

import 'package:winly/globals/controllers/auth_controller.dart';
import 'package:winly/models/notice/notice.dart';
import 'package:winly/services/api/api_service.dart';

class NoticeApi {
  static Future<List<Notice>?> getNotifications() async {
    try {
      final AuthController authController = AuthController();
      final _response = await ApiService.get(
        'api/notifications',
        token: authController.token,
      );

      if (_response.statusCode == 200) {
        List<dynamic> _notifications = _response.data;
        return _notifications
            .map<Notice>((json) => Notice.fromJson(json))
            .toList();
      } else {
        return null;
      }
    } on SocketException catch (_) {
      return null;
    }
  }
}
