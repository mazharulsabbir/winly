import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:winly/models/auth/auth_form_model.dart';
import 'package:winly/services/api/api_service.dart';
import 'package:winly/services/api/url.dart';

class AuthAPI {
  static Future<http.Response?> register(AuthFormModel authFormModel) async {
    try {
      final url = urlBuilder('api/register');
      final responce = await ApiService.post(url, body: authFormModel.toJson());
      return Future.value(responce);
    } on SocketException catch (_) {
      return Future.value(null);
    } on DioError catch (e) {
      return Future.value(e.error);
    }
  }

  static Future<dynamic> login(String email, String password) async {
    try {
      final url = urlBuilder('api/login');
      final responce = await ApiService.post(url, body: {
        'email': email,
        'password': password,
      });
      return Future.value(responce);
    } on SocketException catch (_) {
      return Future.value(null);
    } on DioError catch (e) {
      return Future.value(e.error);
    }
  }

  static Future<dynamic> profile(String token) async {
    try {
      final responce = await ApiService.get('api/user', token: token);
      return Future.value(responce);
    } on SocketException catch (_) {
      return Future.value(null);
    } on DioError catch (e) {
      return Future.value(e.error);
    }
  }
}
