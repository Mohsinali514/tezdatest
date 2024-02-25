import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_fakestoreapi/core/errors/server_exception.dart';
import 'package:flutter_bloc_fakestoreapi/core/errors/server_failure.dart';
import 'package:flutter_bloc_fakestoreapi/data/datasources/user_data_source.dart';
import 'package:flutter_bloc_fakestoreapi/domain/entities/auth.dart';
import 'package:flutter_bloc_fakestoreapi/domain/entities/users.dart';
import 'package:flutter_bloc_fakestoreapi/domain/repositories/user_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class UserRepositoryImpl implements UserRepository {
  final FlutterSecureStorage storage;
  final UserDataSource userDataSource;
  UserRepositoryImpl(this.userDataSource, this.storage);

  @override
  Future<Either<ServerFailure, AuthEntity>> login(
      String email,
      String password,
      ) async {
    try {
      final result = await userDataSource.userLogin(email, password);
      final authModel = result.toEntity();
      return Right(authModel);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, AuthEntity>> signup(
      String name,
      String email,
      String password,
      ) async {
    try {
      final result = await userDataSource.userSignup(name, email, password);
      final authModel = result.toEntity();
      return Right(authModel);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, UserEntity>> userDetail() async {
    try {
      final accessToken = await storage.read(key: 'access_token');
      if (accessToken != null) {
        final jwt = JwtDecoder.decode(accessToken);
        final result = await userDataSource.userDetail(jwt['sub']);
        final userEntity = result.toEntity();
        return Right(userEntity);
      } else {
        return Left(ServerFailure('Unauthenticated'));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

