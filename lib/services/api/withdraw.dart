import 'dart:io';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:winly/services/api/url.dart';

class WithdrawAPI {
  static Future<http.Response?> withdraw(
    String token,
    String phoneNumber,
    int amount,
    String paymentMethod,
  ) async {
    try {
      final url = urlBuilder('api/user-withdraw');
      final response = await http.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: convert.jsonEncode({
            'phone': phoneNumber,
            'amount': amount,
            'payment_method': paymentMethod,
          }));

      print(response.body);
      return Future.value(response);
    } on SocketException catch (_) {
      return null;
    }
  }

  static Future<http.Response?> withdraws(
    String token,
  ) async {
    try {
      final url = urlBuilder('api/withdraw-history');
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print(response.body);
      return Future.value(response);
    } on SocketException catch (_) {
      return null;
    }
  }
}
