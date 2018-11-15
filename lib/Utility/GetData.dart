import 'dart:async';

import 'package:http/http.dart' as http;

class GetData {
  static var responseString = "";

  static getDataString() {}

  static final String BASE_URL = "https://sheetdb.io/api/v1/5be305749e8e2";

  static Future<http.Response> getData(String categories) async {
    var response = await http
        .get(Uri.encodeFull(BASE_URL), headers: {"Accept": "application/json"});
    return response;
//    responseString = response.body;
//    //return response.body;
  }
}
