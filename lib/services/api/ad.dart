import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:winly/services/api/url.dart';

class AdAPI {
  static Future<http.Response?> requestForTicket(
      {required String adStatus}) async {
    try {
      final url = urlBuilder('api/user-ad');

      final response = await http.post(
        Uri.parse(url),
        body: {
          'ad-status': adStatus,
        },
        headers: commonHeader(),
      );
      debugPrint(response.body);
      return Future.value(response);
    } on SocketException catch (_) {
      return null;
    }
  }
}
