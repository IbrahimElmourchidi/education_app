import 'package:dartz/dartz.dart';
import 'package:education_app/src/features/authentication/domain/entities/user_entity.dart';
import 'package:education_app/src/features/authentication/domain/repositories/auth_repo.dart';
import 'package:education_app/src/features/authentication/domain/usercases/get_users.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'mock_auth_repo.dart';

void main() {
  late AuthRepo repo;
  late GetUsers getUsers;

  setUp(() {
    repo = MockAuthRepo();
    getUsers = GetUsers(repo);
  });

  test("should call [AuthRepo.getUsers] and return [List<User>]", () async {
    //arrange
    when(
      () => repo.getUsers(),
    ).thenAnswer((_) async {
      return const Right([User.empty()]);
    });

    // act
    final result = await getUsers();
    // assert
    expect(result, equals(const Right<dynamic, List<User>>([User.empty()])));
    verify(
      () => repo.getUsers(),
    ).called(1);
    verifyNoMoreInteractions(repo);
  });
}
