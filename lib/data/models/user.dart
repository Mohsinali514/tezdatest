import 'package:flutter_bloc_fakestoreapi/domain/entities/users.dart';

class UserModel {
  final int id;
  final String email;
  final String password;
  final String name;
  final String role;
  final String avatar;
  final String creationAt;
  final String updatedAt;
  UserModel({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.role,
    required this.avatar,
    required this.creationAt,
    required this.updatedAt,
  });

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      password: password,
      name: name,
      role: role,
      avatar: avatar,
      creationAt: creationAt,
      updatedAt: updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'name': name,
      'role': role,
      'avatar': avatar,
      'creationAt': creationAt,
      'updatedAt': updatedAt,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      email: map['email'],
      password: map['password'],
      name: map['name']['firstname'],
      role: '',
      avatar: '',
      creationAt: '',
      updatedAt: '',
    );
  }
}
