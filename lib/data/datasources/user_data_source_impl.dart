import 'dart:convert';

import 'package:flutter_bloc_fakestoreapi/core/errors/server_exception.dart';
import 'package:flutter_bloc_fakestoreapi/core/networking/http_service.dart';
import 'package:flutter_bloc_fakestoreapi/data/datasources/user_data_source.dart';
import 'package:flutter_bloc_fakestoreapi/data/models/auth.dart';
import 'package:flutter_bloc_fakestoreapi/data/models/user.dart';
class UserDataSourceImpl implements UserDataSource {
  final HttpService client;
  UserDataSourceImpl(this.client);

  @override
  Future<UserModel> userDetail(int id) async {
    final response = await client.get(endpoint: '/users/$id');
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final UserModel user = UserModel.fromJson(responseBody);
      return user;
    } else {
      return exceptionHandling(response);
    }
  }

  @override
  Future<AuthModel> userLogin(String email, String password) async {
    final body = {"username": email, "password": password};
    final response = await client.post(
      endpoint: '/auth/login',
      body: body,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseBody = jsonDecode(response.body);
      final auth = AuthModel.fromJson(responseBody);
      return auth;
    } else {
      return exceptionHandling(response);
    }
  }

  @override
  Future<AuthModel> userSignup(String name, String email, String password) async { // Added
    final body = {"name": name, "email": email, "password": password}; // Adjust fields as per your API requirements
    final response = await client.post(
      endpoint: '/auth/signup', // Adjust endpoint as per your API requirements
      body: body,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseBody = jsonDecode(response.body);
      final auth = AuthModel.fromJson(responseBody);
      return auth;
    } else {
      return exceptionHandling(response);
    }
  }
}
