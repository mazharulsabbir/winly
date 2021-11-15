import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:winly/models/auth/auth_form_model.dart';
import 'package:winly/services/api/url.dart';

class AuthAPI {
  static Future<http.Response?> register(AuthFormModel authFormModel) {
    try {
      final url = urlBuilder('api/register');
      final responce = http.post(Uri.parse(url),
          body: authFormModel.toJson(), headers: commonHeader());
      return Future.value(responce);
    } on SocketException catch (_) {
      return Future.value(null);
    }
  }
}
