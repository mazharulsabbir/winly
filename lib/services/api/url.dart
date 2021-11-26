const baseUrl = 'https://winly.tauhidthecoder.com';
const supportChatBaseUrl = 'https://winly.tauhidthecoder.com/support-chat';
const youtubeBaseUrl = 'https://www.googleapis.com';
// const BASE_URL = 'http://ring.tauhidthecoder.com';
// const BASE_URL = 'https://ref-system.everestbajar.com';

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
