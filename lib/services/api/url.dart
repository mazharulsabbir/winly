const BASE_URL = 'https://winly.tauhidthecoder.com';
// const BASE_URL = 'http://ring.tauhidthecoder.com';
// const BASE_URL = 'https://ref-system.everestbajar.com';

String urlBuilder(
  String endpoint, {
  List<String>? params,
  String? fields,
  int? limit,
  String? withParam,
}) {
  String baseUrl = "$BASE_URL/$endpoint?";

  if (params != null) {
    if (params.isNotEmpty) {
      params.forEach((param) {
        baseUrl += "$param&";
      });
    } else {
      baseUrl += "";
    }
  }

  return baseUrl;
}

Map<String, String> commonHeader() {
  return {'Accept': "application/json"};
}
