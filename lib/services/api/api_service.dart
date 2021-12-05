import 'package:dio/dio.dart' as dio;
import 'package:pretty_dio_logger/pretty_dio_logger.dart' as interceptor;
import 'dart:convert' as convert;

import 'package:image_picker/image_picker.dart';

class ApiService {
  static const String baseUrl = "https://winly.app/";
  // static const String baseUrl = "https://winly.tauhidthecoder.com/";
  static const String apiKey = "";

  static Future<dynamic> get(
    String url, {
    String? token,
  }) async {
    final _dio = dio.Dio();
    _dio.interceptors.add(
      interceptor.PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );

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
    _dio.interceptors.add(
      interceptor.PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );

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

  static Future<dynamic> postMultipart(
    String url,
    XFile image, {
    String? token,
    Map<String, dynamic>? body,
  }) async {
    final _dio = dio.Dio();
    _dio.interceptors.add(
      interceptor.PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );

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
    } on dio.DioError catch (e) {
      return Future.error(e.message);
    } on Exception catch (e) {
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
    final _dio = dio.Dio();
    _dio.interceptors.add(
      interceptor.PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );

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
    _dio.interceptors.add(
      interceptor.PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );

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

  static Future<dynamic> getVideoDetails(String url) async {
    final _dio = dio.Dio();
    _dio.interceptors.add(
      interceptor.PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );

    dio.Response? responseJson;
    try {
      responseJson = await _dio.get(url);
    } on dio.DioError catch (e) {
      return Future.error(e);
    } on Exception catch (e) {
      return Future.error(e);
    }
    _dio.clear();
    return Future.value(responseJson);
  }
}
