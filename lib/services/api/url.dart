import 'package:flutter/foundation.dart';

const baseUrl = 'https://winly.app';
// const baseUrl = 'https://winly.tauhidthecoder.com';
const supportChatBaseUrl = baseUrl + '/support-chat';
const youtubeBaseUrl = 'https://www.googleapis.com';

String urlBuilder(
  String endpoint, {
  List<String>? params,
  String? fields,
  int? limit,
  String? withParam,
}) {
  String _baseUrl = "$baseUrl/$endpoint?";

  if (params != null) {
    if (params.isNotEmpty) {
      for (var param in params) {
        _baseUrl += "$param&";
      }
    } else {
      _baseUrl += "";
    }
  }

  debugPrint("URL: /$endpoint");
  return _baseUrl;
}

String youtubeUrlBuilder(
  String endpoint, {
  List<String>? params,
  String? fields,
  int? limit,
  String? withParam,
}) {
  String _baseUrl = "$youtubeBaseUrl/$endpoint?";

  if (params != null) {
    if (params.isNotEmpty) {
      for (var param in params) {
        _baseUrl += "$param&";
      }
    } else {
      _baseUrl += "";
    }
  }

  return _baseUrl;
}

Map<String, String> commonHeader() {
  return {'Accept': "application/json"};
}
