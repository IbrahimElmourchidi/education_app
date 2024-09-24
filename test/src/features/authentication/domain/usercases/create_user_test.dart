// what this class depends on?
// Answer -- it depends on auth repo.
// how can we create a fake version of these depenedencies?
// answer -- use mocktail
// how we can control what our dependecies do?
// anser -- using mocktail APIs

import 'package:dartz/dartz.dart';
import 'package:education_app/src/features/authentication/domain/repositories/auth_repo.dart';
import 'package:education_app/src/features/authentication/domain/usercases/create_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'mock_auth_repo.dart';

void main() {
  late CreateUser usecase;
  late AuthRepo repo;
  setUp(() {
    repo = MockAuthRepo();
    usecase = CreateUser(repo);
  });

  const params = CreateUserParams.empty();

  test("should call the [Repository.createUser]", () async {
    // arrange
    when(
      () => repo.createUser(
        createdAt: any(named: 'createdAt'),
        name: any(named: 'name'),
        avatar: any(named: 'avatar'),
      ),
    ).thenAnswer((_) async {
      return const Right(null);
    });
    // act
    final result = await usecase(params);
    // assert
    expect(result, equals(const Right<dynamic, void>(null)));
    verify(
      () => repo.createUser(
        createdAt: params.createdAt,
        name: params.name,
        avatar: params.avatar,
      ),
    ).called(1);
    verifyNoMoreInteractions(repo);
  });
}
