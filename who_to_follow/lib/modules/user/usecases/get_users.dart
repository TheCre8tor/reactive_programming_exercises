import 'package:ruqe/ruqe.dart';
import 'package:who_to_follow/modules/user/domain/entities/user.dart';
import 'package:who_to_follow/modules/user/repositories/base_user_repository.dart';
import 'package:who_to_follow/shared/core/usecases/usecases.dart';

class GetUsers implements Usecases<Iterable<User>, None> {
  final BaseUserRepository _repository;

  const GetUsers({required BaseUserRepository repository})
      : _repository = repository;

  @override
  Future<Result<Iterable<User>, String>> call(None params) async {
    return await _repository.getUsers();
  }
}
