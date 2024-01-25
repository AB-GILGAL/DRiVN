import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NetworkUtility {
  static Future<String?> fetchUrl(Uri uri,
      {Map<String, String>? header}) async {
    try {
      final response = await http.get(uri, headers: header);
      if (response.statusCode != 200) {
        print(response.body);
      }
      if (response.statusCode == 200) {
        return response.body;
      }
      return null;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
