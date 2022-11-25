import 'package:ruqe/ruqe.dart';
import 'package:who_to_follow/modules/user/domain/entities/user.dart';

abstract class BaseUserRepository {
  Future<Result<Iterable<User>, String>> getUsers();
}
