import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repo.dart';

class GetUsers extends UseCase<List<User>> {
  GetUsers(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<List<User>> call() async {
    return await _repo.getUsers();
  }
}
