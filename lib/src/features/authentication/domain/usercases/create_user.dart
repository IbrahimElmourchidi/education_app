import 'package:education_app/src/core/utils/typedef.dart';
import 'package:education_app/src/features/authentication/domain/repositories/auth_repo.dart';

class CreateUser {
  const CreateUser(this._repo);

  final AuthRepo _repo;

  ResultVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    return await _repo.createUser(
      createdAt: createdAt,
      name: name,
      avatar: avatar,
    );
  }
}
