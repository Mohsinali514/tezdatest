import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_fakestoreapi/core/errors/server_failure.dart';
import 'package:flutter_bloc_fakestoreapi/domain/entities/users.dart';
import 'package:flutter_bloc_fakestoreapi/domain/repositories/user_repository.dart';

class UserDetail {
  final UserRepository userRepository;
  UserDetail(this.userRepository);

  Future<Either<ServerFailure, UserEntity>> call() async {
    return await userRepository.userDetail();
  }
}
