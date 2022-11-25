import 'package:ruqe/ruqe.dart';
import 'package:who_to_follow/modules/users/domain/entities/user.dart';
import 'package:who_to_follow/modules/users/repositories/base_users_repository.dart';
import 'package:who_to_follow/modules/users/repositories/user_repository.error.dart';
import 'package:who_to_follow/modules/users/services/http/user_service.interface.dart';

class UsersRepository implements BaseUsersRepository {
  final BaseUsersService userService;

  const UsersRepository(this.userService);

  @override
  Future<Result<Iterable<User>, String>> getUsers() async {
    const message = "[error]: unable to get users, try again later!";

    try {
      final response = await userService.getUsers();
      return Ok(response);
    } on UserRepositoryError catch (err) {
      return Err(err.message ?? message);
    }
  }
}
