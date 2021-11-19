import 'package:dio/dio.dart' as dio;
import 'dart:convert' as convert;

class ApiService {
  static const String baseUrl = "https://winly.tauhidthecoder.com/";
  static const String apiKey = "";

  static Future<dynamic> get(
    String url, {
    String? token,
  }) async {
    final _dio = dio.Dio();

    dio.Response? responseJson;
    try {
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
    } on dio.DioError catch (e) {
      return Future.error(e);
    } on Exception catch (e) {
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
    } on dio.DioError catch (e) {
      return Future.error(e);
    } on Exception catch (e) {
      return Future.error(e);
    }
    _dio.clear();
    return Future.value(responseJson);
  }

  static Future<dynamic> put(
    String url, {
    String? token,
    Map<String, dynamic>? body,
  }) async {
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
    } on dio.DioError catch (e) {
      return Future.error(e);
    } on Exception catch (e) {
      return Future.error(e);
    }
    _dio.clear();
    return Future.value(responseJson);
  }

  static Future<dynamic> delete(
    String url, {
    String? token,
  }) async {
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
    } on dio.DioError catch (e) {
      return Future.error(e);
    } on Exception catch (e) {
      return Future.error(e);
    }

    _dio.clear();
    return Future.value(responseJson);
  }
}
