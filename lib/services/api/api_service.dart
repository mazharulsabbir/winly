import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'dart:convert' as convert;

import 'package:image_picker/image_picker.dart';

class ApiService {
  // static const String baseUrl = "https://winly.app/";
  static const String baseUrl = "https://winly.tauhidthecoder.com/";
  static const String apiKey = "";

  static Future<dynamic> get(
    String url, {
    String? token,
  }) async {
    final _dio = dio.Dio();

    dio.Response? responseJson;
    try {
      debugPrint("GET: /$url");

      responseJson = await _dio.get(
        baseUrl + url,
        options: dio.Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            'Authorization': 'Bearer $token'
          },
        ),
      );
      // debugPrint(responseJson.toString());
    } on dio.DioError catch (e) {
      debugPrint(e.toString());
      return Future.error(e);
    } on Exception catch (e) {
      debugPrint(e.toString());
      return Future.error(e);
    }
    _dio.clear();
    return Future.value(responseJson);
  }

  static Future<dynamic> post(
    String url, {
    String? token,
    Map<String, dynamic>? body,
  }) async {
    debugPrint("POST: /$url");

    final _dio = dio.Dio();
    dio.Response? responseJson;
    try {
      responseJson = await _dio.post(
        baseUrl + url,
        data: convert.jsonEncode(body),
        options: dio.Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            'Authorization': 'Bearer $token'
          },
        ),
      );
      debugPrint(responseJson.toString());
    } on dio.DioError catch (e) {
      debugPrint(e.toString());
      return Future.error(e);
    } on Exception catch (e) {
      debugPrint(e.toString());
      return Future.error(e);
    }
    _dio.clear();
    return Future.value(responseJson);
  }

  static Future<dynamic> postMultipart(
    String url,
    XFile image, {
    String? token,
    Map<String, dynamic>? body,
  }) async {
    debugPrint("POST: /$url");

    final _dio = dio.Dio();
    dio.Response? responseJson;
    try {
      String fileName = image.path.split('/').last;

      dio.FormData formData = dio.FormData.fromMap({
        "profile_img": await dio.MultipartFile.fromFile(
          image.path,
          filename: "profile_img",
        ),
      });

      responseJson = await _dio.post(
        baseUrl + url,
        data: formData,
        options: dio.Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            'Authorization': 'Bearer $token'
          },
        ),
      );
      debugPrint(responseJson.toString());
    } on dio.DioError catch (e) {
      debugPrint(e.toString());
      return Future.error(e.message);
    } on Exception catch (e) {
      debugPrint(e.toString());
      return Future.error(e.toString());
    }

    _dio.clear();
    return Future.value(responseJson);
  }

  static Future<dynamic> put(
    String url, {
    String? token,
    Map<String, dynamic>? body,
  }) async {
    debugPrint("PUT: /$url");

    final _dio = dio.Dio();
    dio.Response? responseJson;
    try {
      responseJson = await _dio.put(
        baseUrl + url,
        data: body,
        options: dio.Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            'Authorization': 'Bearer $token'
          },
        ),
      );
      debugPrint(responseJson.toString());
    } on dio.DioError catch (e) {
      debugPrint(e.toString());
      return Future.error(e);
    } on Exception catch (e) {
      debugPrint(e.toString());
      return Future.error(e);
    }
    _dio.clear();
    return Future.value(responseJson);
  }

  static Future<dynamic> delete(
    String url, {
    String? token,
  }) async {
    debugPrint("DELETE: /$url");

    final _dio = dio.Dio();
    dio.Response? responseJson;
    try {
      responseJson = await _dio.delete(
        baseUrl + url,
        options: dio.Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            'Authorization': 'Bearer $token'
          },
        ),
      );
      debugPrint(responseJson.toString());
    } on dio.DioError catch (e) {
      debugPrint(e.toString());
      return Future.error(e);
    } on Exception catch (e) {
      debugPrint(e.toString());
      return Future.error(e);
    }

    _dio.clear();
    return Future.value(responseJson);
  }

  static Future<dynamic> getVideoDetails(String url) async {
    debugPrint("GET: /$url");

    final _dio = dio.Dio();
    dio.Response? responseJson;
    try {
      responseJson = await _dio.get(url);
      debugPrint(responseJson.toString());
    } on dio.DioError catch (e) {
      debugPrint(e.toString());
      return Future.error(e);
    } on Exception catch (e) {
      debugPrint(e.toString());
      return Future.error(e);
    }
    _dio.clear();
    return Future.value(responseJson);
  }
}
