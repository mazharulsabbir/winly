import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:winly/services/api/api_service.dart';
import 'package:winly/services/api/url.dart';

class AdAPI {
  static Future<http.Response?> requestForTicket(
      {required String adStatus, String? token}) async {
    try {
      final url = urlBuilder('api/user-ad');

      final response = await http.post(Uri.parse(url), body: {
        'ad_status': adStatus,
      }, headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $token'
      });
      // debugPrint(response.body);
      return Future.value(response);
    } on SocketException catch (_) {
      return null;
    }
  }
}
