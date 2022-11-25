import 'package:ruqe/ruqe.dart';
import 'package:who_to_follow/modules/users/domain/entities/user.dart';

abstract class BaseUsersRepository {
  Future<Result<Iterable<User>, String>> getUsers();
}
