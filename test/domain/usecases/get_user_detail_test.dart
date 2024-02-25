import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_fakestoreapi/domain/entities/users.dart';
import 'package:flutter_bloc_fakestoreapi/domain/usecases/get_user_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'mock_user_repository.mocks.dart';

void main() {
  late UserDetail usecase;
  late MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    usecase = UserDetail(mockUserRepository);
  });

  const sampleUser = UserEntity(
    id: 1,
    email: 'john@mail.com',
    password: 'changeme',
    name: 'Jhon',
    role: 'customer',
    avatar: 'https://i.imgur.com/LDOO4Qs.jpg',
    creationAt: '2023-11-28T10:07:58.000Z',
    updatedAt: '2023-11-28T10:07:58.000Z',
  );

  test('user detail from repository', () async {
    when(mockUserRepository.userDetail())
        .thenAnswer((_) async => const Right(sampleUser));

    final result = await usecase();

    expect(result, equals(const Right(sampleUser)));
    verify(mockUserRepository.userDetail());
    verifyNoMoreInteractions(mockUserRepository);
  });
}
