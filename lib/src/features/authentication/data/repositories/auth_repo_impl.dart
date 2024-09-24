import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/typedef.dart';
import '../datasources/auth_remote_data_source.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  AuthRepoImpl(this._remoteDataSource);

  AuthRemoteDataSource _remoteDataSource;

  @override
  ResultVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    try {
      final result = await _remoteDataSource.createUser(
        avatar: avatar,
        createdAt: createdAt,
        name: name,
      );
      return Right(null);
    } on APIException catch (e) {
      return Left(
        ApiFailure.fromException(e),
      );
    }
  }

  @override
  ResultFuture<List<User>> getUsers() async {
    try {
      final users = await _remoteDataSource.getUsers();
      return Right(users);
    } on APIException catch (e) {
      return Left(
        ApiFailure.fromException(e),
      );
    }
  }
}
