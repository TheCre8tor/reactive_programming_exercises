import 'dart:convert';

import 'package:flutter/foundation.dart' show immutable;
import 'package:who_to_follow/modules/users/domain/entities/user.dart';
import 'package:who_to_follow/modules/users/repositories/user_repository.error.dart';
import 'package:who_to_follow/modules/users/services/http/user_service.interface.dart';
import 'package:http/http.dart';

@immutable
class UserService implements BaseUsersService {
  final Client client;

  const UserService({required this.client});

  @override
  Future<Iterable<User>> getUsers() async {
    final response = await client.get(
      Uri.parse("https://api.github.com/usersx"),
    );

    if (response.statusCode == 200) {
      final parsedUsers = jsonDecode(response.body) as List;

      final users = parsedUsers.map((user) {
        return User.fromMap(user);
      }).toList();

      return users;
    }

    throw UserRepositoryError(response.body);
  }
}
