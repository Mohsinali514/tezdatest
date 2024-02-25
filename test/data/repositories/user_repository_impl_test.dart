import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_fakestoreapi/core/errors/server_exception.dart';
import 'package:flutter_bloc_fakestoreapi/core/errors/server_failure.dart';
import 'package:flutter_bloc_fakestoreapi/data/models/auth.dart';
import 'package:flutter_bloc_fakestoreapi/data/models/user.dart';
import 'package:flutter_bloc_fakestoreapi/data/repositories/user_repository_impl.dart';
import 'package:flutter_bloc_fakestoreapi/domain/entities/auth.dart';
import 'package:flutter_bloc_fakestoreapi/domain/entities/users.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../datasources/mock_user_data_source.mocks.dart';
import 'mock_storage.mocks.dart';

void main() {
  late UserRepositoryImpl userRepositoryImpl;
  late MockUserDataSource mockUserDataSource;
  late MockFlutterSecureStorage storage;

  setUp(() {
    mockUserDataSource = MockUserDataSource();
    storage = MockFlutterSecureStorage();
    userRepositoryImpl = UserRepositoryImpl(mockUserDataSource, storage);
  });

  const tEmail = 'jhon@mail.com';
  const tPassword = '123';
  const tIdUser = 2;

  final sampleUser = UserModel(
      id: 1,
      email: 'john@mail.com',
      password: 'changeme',
      name: 'Jhon',
      role: 'customer',
      avatar: 'https://i.imgur.com/LDOO4Qs.jpg',
      creationAt: '2023-11-28T10:07:58.000Z',
      updatedAt: '2023-11-28T10:07:58.000Z');

  final sampleLogin = AuthModel(
    accessToken:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTY3Mjc2NjAyOCwiZXhwIjoxNjc0NDk0MDI4fQ.kCak9sLJr74frSRVQp0_27BY4iBCgQSmoT3vQVWKzJg',
    refreshToken:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTY3Mjc2NjAyOCwiZXhwIjoxNjcyODAyMDI4fQ.P1_rB3hJ5afwiG4TWXLq6jOAcVJkvQZ2Z-ZZOnQ1dZw',
  );

  test('user login from user data source', () async {
    when(mockUserDataSource.userLogin(tEmail, tPassword))
        .thenAnswer((_) async => sampleLogin);

    final result = await userRepositoryImpl.login(tEmail, tPassword);

    verify(mockUserDataSource.userLogin(tEmail, tPassword));
    expect(result, isA<Right<Failure, AuthEntity>>());
  });

  test('user login from user data source is unsuccessful', () async {
    when(mockUserDataSource.userLogin(tEmail, tPassword))
        .thenThrow(ServerException());

    final result = await userRepositoryImpl.login(tEmail, tPassword);

    expect(result, isA<Left<Failure, AuthEntity>>());
  });

  test('user detail from user data source', () async {
    when(mockUserDataSource.userDetail(tIdUser)).thenAnswer(
      (_) async => sampleUser,
    );

    final result = await userRepositoryImpl.userDetail();
    //verify(mockUserDataSource.userDetail(tIdUser));
    expect(result, isA<Left<Failure, UserEntity>>());
  });

  test('user detail from user data source is unsuccessful', () async {
    when(mockUserDataSource.userDetail(tIdUser)).thenThrow(ServerException());

    final result = await userRepositoryImpl.userDetail();

    expect(result, isA<Left<Failure, UserEntity>>());
  });
}
