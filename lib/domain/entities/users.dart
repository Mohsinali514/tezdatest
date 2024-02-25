import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int id;
  final String email;
  final String password;
  final String name;
  final String role;
  final String avatar;
  final String creationAt;
  final String updatedAt;
  const UserEntity({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.role,
    required this.avatar,
    required this.creationAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props =>
      [id, email, password, name, role, avatar, creationAt, updatedAt];
}
