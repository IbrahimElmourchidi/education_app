import 'package:equatable/equatable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../repositories/auth_repo.dart';

class CreateUser extends UseCaseWithParams<void, CreateUserParams> {
  const CreateUser(this._repo);

  final AuthRepo _repo;

  @override
  ResultVoid call(CreateUserParams params) async {
    return await _repo.createUser(
      createdAt: params.createdAt,
      name: params.name,
      avatar: params.avatar,
    );
  }
}

class CreateUserParams extends Equatable {
  final String createdAt;
  final String name;
  final String avatar;

  const CreateUserParams({
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  const CreateUserParams.empty() : this(createdAt: '', name: '', avatar: '');

  @override
  List<Object?> get props => [name, createdAt, avatar];
}
