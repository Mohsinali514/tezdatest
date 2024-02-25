import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_fakestoreapi/core/errors/server_failure.dart';
import 'package:flutter_bloc_fakestoreapi/domain/entities/auth.dart';
import 'package:flutter_bloc_fakestoreapi/domain/entities/users.dart';

abstract class UserRepository {
  Future<Either<ServerFailure, AuthEntity>> login(
      String email,
      String password,
      );

  Future<Either<ServerFailure, AuthEntity>> signup(
      String name,
      String email,
      String password,
      );

  Future<Either<ServerFailure, UserEntity>> userDetail();
}

