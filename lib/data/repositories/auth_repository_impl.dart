import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_fakestoreapi/core/errors/server_exception.dart';
import 'package:flutter_bloc_fakestoreapi/core/errors/server_failure.dart';
import 'package:flutter_bloc_fakestoreapi/data/datasources/user_data_source.dart';
import 'package:flutter_bloc_fakestoreapi/domain/entities/auth.dart';
import 'package:flutter_bloc_fakestoreapi/domain/repositories/auth_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FlutterSecureStorage storage;
  final UserDataSource userDataSource;

  AuthRepositoryImpl(this.storage, this.userDataSource);

  @override
  Stream<AuthEntity?> getCurrentUser() async* {
    final accessToken = await storage.read(key: 'access_token');
    final refreshToken = await storage.read(key: 'refresh_token');
    if (accessToken != null && refreshToken != null) {
      if (!JwtDecoder.isExpired(accessToken)) {
        yield AuthEntity(accessToken: accessToken, refreshToken: refreshToken);
      }
    }
  }

  @override
  Future<void> logout() async {
    await storage.delete(key: 'access_token');
    await storage.delete(key: 'refresh_token');
  }

  @override
  Future<Either<ServerFailure, AuthEntity>> login(
      String email, String password) async {
    try {
      final result = await userDataSource.userLogin(email, password);
      final authEntity = result.toEntity();
      await storage.write(key: 'access_token', value: authEntity.accessToken);
      await storage.write(
          key: 'refresh_token', value: authEntity.refreshToken);
      return Right(authEntity);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, AuthEntity>> checkSignedStatus() async {
    try {
      final accessToken = await storage.read(key: 'access_token');
      final refreshToken = await storage.read(key: 'refresh_token');
      if (accessToken != null) {
        // if (JwtDecoder.isExpired(accessToken)) {
        //   return Left(ServerFailure('Token Expired'));
        // } else {
        final authEntity =
        AuthEntity(accessToken: accessToken, refreshToken: refreshToken!);
        return Right(authEntity);
        // }
      } else {
        return Left(ServerFailure('Unauthenticated'));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, AuthEntity>> signup( // Added
      String name, String email, String password) async {
    try {
      final result = await userDataSource.userSignup(name, email, password); // Adjust as per your UserDataSource
      final authEntity = result.toEntity();
      await storage.write(key: 'access_token', value: authEntity.accessToken);
      await storage.write(
          key: 'refresh_token', value: authEntity.refreshToken);
      return Right(authEntity);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
