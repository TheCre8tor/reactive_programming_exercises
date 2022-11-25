import 'package:ruqe/ruqe.dart';
import 'package:who_to_follow/modules/user/domain/entities/user.dart';
import 'package:who_to_follow/modules/user/repositories/base_user_repository.dart';
import 'package:who_to_follow/modules/user/services/http/user_service.interface.dart';
import 'package:who_to_follow/shared/core/errors/server_exception.dart';

class UserRepository implements BaseUserRepository {
  final BaseUserService _userService;

  const UserRepository({required BaseUserService service})
      : _userService = service;

  @override
  Future<Result<Iterable<User>, String>> getUsers() async {
    const message = "[error]: unable to get users, try again later!";

    try {
      final response = await _userService.getUsers();
      return Ok(response);
    } on ServerException catch (err) {
      return Err(err.message ?? message);
    }
  }
}
