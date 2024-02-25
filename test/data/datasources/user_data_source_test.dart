import 'package:flutter_bloc_fakestoreapi/data/datasources/user_data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'mock_client.mocks.dart';

void main() {
  late UserDataSourceImpl dataSource;
  late MockHttpService mockClient;

  const tIdUser = 1;
  const tEmail = 'john@mail.com';
  const tPassword = 'changeme';
  const loginBody = {'email': tEmail, 'password': tPassword};
  const sampleLogin = '''{
    "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjMsImlhdCI6MTcwMTIzNDY4OSwiZXhwIjoxNzAyOTYyNjg5fQ.AZn2CKOMjZ3KAU3LL6iBFQsCv6_pxGM4-z-R33OyO9E",
    "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjMsImlhdCI6MTcwMTIzNDY4OSwiZXhwIjoxNzAxMjcwNjg5fQ._E9lXyHyi3IAU2meQbOnOj2cMq4gdXP6J48QjciDVxE"
    }''';
  const sampleResponse = '''{
    "id": 1,
    "email": "john@mail.com",
    "password": "changeme",
    "name": "Jhon",
    "role": "customer",
    "avatar": "https://i.imgur.com/LDOO4Qs.jpg",
    "creationAt": "2023-11-28T10:07:58.000Z",
    "updatedAt": "2023-11-28T10:07:58.000Z"
    }''';

  setUp(() async {
    mockClient = MockHttpService();
    dataSource = UserDataSourceImpl(mockClient);
  });

  test("get request on a url to get user detail", () async {
    when(mockClient.get(endpoint: '/users/$tIdUser'))
        .thenAnswer((_) async => http.Response(sampleResponse, 200));
    await dataSource.userDetail(tIdUser);
    verify(mockClient.get(endpoint: '/users/$tIdUser'));
  });

  test('post request on a url to user login', () async {
    when(mockClient.post(
      endpoint: '/auth/login',
      body: loginBody,
    )).thenAnswer((_) async => http.Response(sampleLogin, 200));

    await dataSource.userLogin(tEmail, tPassword);

    verify(mockClient.post(
      endpoint: '/auth/login',
      body: loginBody,
    ));
  });
}
