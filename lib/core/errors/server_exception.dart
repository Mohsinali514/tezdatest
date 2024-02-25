import 'dart:convert';

import 'package:http/http.dart' as http;

class ServerException implements Exception {
  final String? _message;

  ServerException([this._message]);

  @override
  String toString() {
    return "$_message";
  }
}

class FetchDataException extends ServerException {
  FetchDataException([String? message]) : super(message);
}

class BadRequestException extends ServerException {
  BadRequestException([message]) : super(message);
}

class UnauthorisedException extends ServerException {
  UnauthorisedException([message]) : super(message);
}

class InvalidInputException extends ServerException {
  InvalidInputException([String? message]) : super(message);
}

dynamic exceptionHandling(http.Response response) {
  switch (response.statusCode) {
    case 400:
      throw BadRequestException(
          jsonDecode(response.body)['message'] ?? 'Bad request');
    case 401:
      throw UnauthorisedException(jsonDecode(response.body)['message'] ??
          'Please check email or password');
    case 403:
      throw UnauthorisedException(
          jsonDecode(response.body)['message'] ?? 'Forbidden Access');
    case 500:
    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}
