import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_fakestoreapi/core/errors/server_failure.dart';
import 'package:flutter_bloc_fakestoreapi/domain/entities/auth.dart';
import 'package:flutter_bloc_fakestoreapi/domain/repositories/user_repository.dart';

class UserSignup {
  final UserRepository userRepository;

  UserSignup(this.userRepository);

  Future<Either<ServerFailure, AuthEntity>> call({
    required String name,
    required String email,
    required String password,
  }) async {
    return await userRepository.signup(name, email, password);
  }
}
