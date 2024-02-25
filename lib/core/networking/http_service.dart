import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpService {
  final http.Client _http;
  // ignore: constant_identifier_names
  static const BASE_URL = 'https://fakestoreapi.com';
  HttpService(this._http);
  Future<http.Response> get({
    String? endpoint,
  }) async {
    final response = await _http.get(
      Uri.parse("$BASE_URL$endpoint"),
    );
    return response;
  }

  Future<http.Response> post({
    String? endpoint,
    Map<String, dynamic>? body,
  }) async {
    final response = await _http.post(
      Uri.parse("$BASE_URL$endpoint"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(body),
    );
    return response;
  }
}
