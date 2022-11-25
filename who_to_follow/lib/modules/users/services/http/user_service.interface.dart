import 'package:who_to_follow/modules/users/domain/entities/user.dart';

abstract class BaseUsersService {
  Future<Iterable<User>> getUsers();
}
