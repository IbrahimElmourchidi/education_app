import 'dart:convert';

import 'package:education_app/src/core/errors/exceptions.dart';
import 'package:education_app/src/core/utils/constants.dart';
import 'package:education_app/src/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:education_app/src/features/authentication/data/datasources/auth_remote_data_source_impl.dart';
import 'package:education_app/src/features/authentication/data/models/user_model.dart';
import 'package:education_app/src/features/authentication/domain/entities/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late MockClient client;
  late AuthRemoteDataSource remoteDataSource;

  setUp(() {
    client = MockClient();
    remoteDataSource = AuthRemoteDataSourceImpl(client);
    registerFallbackValue(Uri());
  });

  group("createUser", () {
    test(
      "Should return [void] when the response of the server is 2xx",
      () async {
        // arrange
        when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
          (_) async => http.Response('Success', 201),
        );

        // act
        final methodCall = remoteDataSource.createUser;

        // assert
        expect(
          methodCall(
            avatar: 'avatar',
            createdAt: 'createdAt',
            name: 'name',
          ),
          completes,
        );

        verify(() => client.post(
              Uri.parse(kBaseUrl + AuthRemoteDataSourceImpl.createUserEndPoint),
              body: jsonEncode({
                'avatar': 'avatar',
                'createdAt': 'createdAt',
                'name': 'name',
              }),
            )).called(1);
        verifyNoMoreInteractions(client);
      },
    );

    test(
      'should throw [ApiException] when the status code is not 2xx',
      () {
        // arrange
        when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
          (_) async => http.Response('fail', 400),
        );

        // act
        final methodCall = remoteDataSource.createUser;

        // assert
        expect(
          () async => methodCall(
            avatar: 'avatar',
            createdAt: 'createdAt',
            name: 'name',
          ),
          throwsA(const APIException(message: 'fail', statusCode: 400)),
        );

        verify(() => client.post(
              Uri.parse(kBaseUrl + AuthRemoteDataSourceImpl.createUserEndPoint),
              body: jsonEncode({
                'avatar': 'avatar',
                'createdAt': 'createdAt',
                'name': 'name',
              }),
            )).called(1);
        verifyNoMoreInteractions(client);
      },
    );
  });

  group('getUsers', () {
    test(
        "should return [List<UserModel>] if the request to the server was successful",
        () async {
      const tUsersList = [UserModel.empty()];
      //arrange
      when(() => client.get(any())).thenAnswer(
        (_) async => http.Response(jsonEncode([tUsersList[0].toMap()]), 200),
      );

      //act
      final result = await remoteDataSource.getUsers();

      // assert
      expect(result, isA<List<User>>());

      verify(() => client.get(
            Uri.parse(kBaseUrl + AuthRemoteDataSourceImpl.getUserEndPoint),
          )).called(1);
      verifyNoMoreInteractions(client);
    });
    test(
      'should throw [ApiException] when the status code is not 2xx',
      () {
        // arrange
        when(() => client.get(any())).thenAnswer(
          (_) async => http.Response('not found', 404),
        );

        // act
        final methodCall = remoteDataSource.getUsers;

        // assert
        expect(
          () async => methodCall(),
          throwsA(const APIException(message: 'not found', statusCode: 404)),
        );

        verify(() => client.get(
              Uri.parse(kBaseUrl + AuthRemoteDataSourceImpl.getUserEndPoint),
            )).called(1);
        verifyNoMoreInteractions(client);
      },
    );
  });
}
