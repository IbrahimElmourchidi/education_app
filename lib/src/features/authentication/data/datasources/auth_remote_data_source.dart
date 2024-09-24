import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<void> createUser({
    required String avatar,
    required String createdAt,
    required String name,
  });

  Future<List<UserModel>> getUsers();
}
