import 'package:ruqe/ruqe.dart';
import 'package:who_to_follow/modules/users/domain/entities/user.dart';

abstract class BaseUserService {
  Future<Result<Iterable<User>, String>> getUsers();
}
