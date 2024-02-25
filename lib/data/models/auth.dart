import 'package:flutter_bloc_fakestoreapi/domain/entities/auth.dart';

class AuthModel {
  final String accessToken;
  final String refreshToken;
  AuthModel({
    required this.accessToken,
    required this.refreshToken,
  });

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
    };
  }

  factory AuthModel.fromJson(Map<String, dynamic> map) {
    return AuthModel(
      accessToken: map.containsKey('access_token') ? map['access_token'] : map['token'],
      refreshToken: map.containsKey('refresh_token') ? map['refresh_token'] : map['token'],
    );
  }

  AuthEntity toEntity() {
    return AuthEntity(accessToken: accessToken, refreshToken: refreshToken);
  }
}
