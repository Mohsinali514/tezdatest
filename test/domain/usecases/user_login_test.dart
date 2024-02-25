import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_fakestoreapi/domain/entities/auth.dart';
import 'package:flutter_bloc_fakestoreapi/domain/usecases/user_login.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'mock_user_repository.mocks.dart';

void main() {
  late UserLogin usecase;
  late MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    usecase = UserLogin(mockUserRepository);
  });

  const String tEmail = "jhon";
  const String tPassword = "passA";

  const sampleLogin = AuthEntity(
    accessToken:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTY3Mjc2NjAyOCwiZXhwIjoxNjc0NDk0MDI4fQ.kCak9sLJr74frSRVQp0_27BY4iBCgQSmoT3vQVWKzJg',
    refreshToken:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTY3Mjc2NjAyOCwiZXhwIjoxNjcyODAyMDI4fQ.P1_rB3hJ5afwiG4TWXLq6jOAcVJkvQZ2Z-ZZOnQ1dZw',
  );

  test('user login from repository', () async {
    when(mockUserRepository.login(tEmail, tPassword))
        .thenAnswer((_) async => const Right(sampleLogin));

    final result = await usecase(tEmail, tPassword);

    expect(result, equals(const Right(sampleLogin)));
    verify(mockUserRepository.login(tEmail, tPassword));
    verifyNoMoreInteractions(mockUserRepository);
  });
}
