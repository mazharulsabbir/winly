import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:winly/models/auth/auth_form_model.dart';
import 'package:winly/services/api/api_service.dart';
import 'package:winly/services/api/url.dart';

class AuthAPI {
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

  static Future<http.Response?> register(AuthFormModel form) async {
    try {
      final url = urlBuilder('api/register');
      final response = await http.post(
        Uri.parse(url),
        body: form.toJson(),
        headers: commonHeader(),
      );

      return Future.value(response);
    } on SocketException catch (e) {
      debugPrint('Socket error:$e');
      return null;
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<http.Response?> login({
    required String email,
    required String password,
  }) async {
    try {
      final url = urlBuilder('api/login');

      final response = await http.post(
        Uri.parse(url),
        body: {
          'email': email,
          'password': password,
        },
        headers: commonHeader(),
      );
      return response;
    } on SocketException catch (_) {
      return null;
    }
  }

  static Future<http.Response?> verify({
    required String code,
    required String email,
  }) async {
    try {
      final url = urlBuilder('api/email-verify');

      debugPrint("==== Verify Email Address ====");

      final response = await http.post(
        Uri.parse(url),
        body: {
          "email": email,
          "verification_code": code,
        },
        headers: commonHeader(),
      );

      return Future.value(response);
    } on SocketException catch (_) {
      return null;
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<http.Response?> resendVerificationEmail({
    required String email,
  }) async {
    try {
      final url = urlBuilder('api/resend-email-verify');

      final response = await http.post(
        Uri.parse(url),
        body: convert.jsonEncode({
          "email": email,
        }),
        headers: commonHeader(),
      );

      return Future.value(response);
    } on SocketException catch (_) {
      return null;
    }
  }

  static Future<http.Response?> setNewPassword(
      String code, String password) async {
    try {
      final url = urlBuilder('api/reset-password');

      final response = await http.post(
        Uri.parse(url),
        body: {
          "password_reset_code": code,
          "new_password": password,
        },
        headers: commonHeader(),
      );

      return Future.value(response);
    } on SocketException catch (_) {
      return null;
    }
  }

  static Future<http.Response?> sendForgetPassResquest(String email) async {
    try {
      final url = urlBuilder('api/forgot-password');
      final response = await http.post(
        Uri.parse(url),
        body: {'email': email},
        headers: commonHeader(),
      );

      return Future.value(response);
    } on SocketException catch (e) {
      debugPrint('Socket error:$e');
      return null;
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<http.Response?> updateProfile({
    String? token,
    required String? name,
    required String? email,
    required String? phoneNumber,
  }) async {
    try {
      final _url = urlBuilder('api/user');
      if (token == null) {
        return Future.error('Unauthorized!');
      }

      Map<String, dynamic> _body = {};

      if (name != null) _body['name'] = name;
      if (email != null) _body['email'] = email;
      if (phoneNumber != null) _body['phone'] = phoneNumber;

      final response = await http.post(
        Uri.parse(_url),
        body: convert.jsonEncode(_body),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      return Future.value(response);
    } on SocketException catch (_) {
      return null;
    }
  }

  static Future<http.Response?> me(String token) async {
    try {
      final url = urlBuilder('api/user');

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      return Future.value(response);
    } on SocketException catch (_) {
      return null;
    }
  }
}
