import 'package:dartz/dartz.dart';
import 'package:education_app/src/core/errors/exceptions.dart';
import 'package:education_app/src/core/errors/failure.dart';
import 'package:education_app/src/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:education_app/src/features/authentication/data/models/user_model.dart';
import 'package:education_app/src/features/authentication/data/repositories/auth_repo_impl.dart';
import 'package:education_app/src/features/authentication/domain/entities/user_entity.dart';
import 'package:education_app/src/features/authentication/domain/repositories/auth_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteDataSource extends Mock implements AuthRemoteDataSource {}

void main() {
  late AuthRemoteDataSource remoteDataSource;

  late AuthRepoImpl repoImpl;

  const createdAt = 'createdAt';
  const avatar = 'avatar';
  const name = 'name';

  const tException = APIException(
    message: 'unknown error',
    statusCode: 500,
  );

  setUp(() {
    remoteDataSource = MockRemoteDataSource();
    repoImpl = AuthRepoImpl(remoteDataSource);
  });

  group(
    "createUser",
    () {
      test(
        "Should call [RemoteDataSource.createUser] and complete successfully when the call to the remote source is successful",
        () async {
          //arrange
          when(
            () => remoteDataSource.createUser(
              avatar: any(named: 'avatar'),
              createdAt: any(named: 'createdAt'),
              name: any(named: 'name'),
            ),
          ).thenAnswer((_) async => Future.value());

          //act
          final result = await repoImpl.createUser(
            avatar: avatar,
            name: name,
            createdAt: createdAt,
          );

          //assert
          expect(result, equals(const Right(null)));
          verify(
            () => remoteDataSource.createUser(
              avatar: avatar,
              createdAt: createdAt,
              name: name,
            ),
          ).called(1);
          verifyNoMoreInteractions(remoteDataSource);
        },
      );

      test(
        "Should return a [ApiFailure] when the call to the remote source is unsuccessful",
        () async {
          // arrange
          when(
            () => remoteDataSource.createUser(
              avatar: any(named: 'avatar'),
              createdAt: any(named: 'createdAt'),
              name: any(named: 'name'),
            ),
          ).thenThrow(
            tException,
          );
          // act
          final result = await repoImpl.createUser(
            createdAt: createdAt,
            name: name,
            avatar: avatar,
          );

          expect(
            result,
            Left(
              ApiFailure(
                message: tException.message,
                statusCode: tException.statusCode,
              ),
            ),
          );

          verify(() => remoteDataSource.createUser(
                avatar: avatar,
                createdAt: createdAt,
                name: name,
              )).called(1);

          verifyNoMoreInteractions(remoteDataSource);
        },
      );
    },
  );

  group('getUsers', () {
    List<UserModel> tResult = [UserModel.empty()];
    test(
        "should call [AuthRepo.getUser] and return a list of users if successful",
        () async {
      // arrange
      when(() => remoteDataSource.getUsers())
          .thenAnswer((_) async => Future.value(tResult));
      // act
      final result = await repoImpl.getUsers();

      // assert
      expect(result, equals(Right(tResult)));

      verify(() => remoteDataSource.getUsers()).called(1);

      verifyNoMoreInteractions(remoteDataSource);
    });

    test(
      "Should return a [ApiFailure] when the call to the remote source is unsuccessful",
      () async {
        // arrange
        when(
          () => remoteDataSource.getUsers(),
        ).thenThrow(
          tException,
        );
        // act
        final result = await repoImpl.getUsers();

        expect(
          result,
          Left(
            ApiFailure(
              message: tException.message,
              statusCode: tException.statusCode,
            ),
          ),
        );

        verify(() => remoteDataSource.getUsers()).called(1);

        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });
}
