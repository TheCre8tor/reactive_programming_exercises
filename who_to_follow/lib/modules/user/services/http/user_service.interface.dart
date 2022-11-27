import 'package:who_to_follow/modules/user/domain/entities/user.dart';

abstract class BaseUserService {
  Future<Iterable<User>> getUsers([int since]);
}
