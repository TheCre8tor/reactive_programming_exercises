import 'dart:convert';

import 'package:flutter/foundation.dart' show immutable;
import 'package:ruqe/ruqe.dart';
import 'package:who_to_follow/modules/users/domain/entities/user.dart';
import 'package:who_to_follow/modules/users/services/http/user_service.error.dart';
import 'package:who_to_follow/modules/users/services/http/user_service.interface.dart';
import 'package:http/http.dart';

@immutable
class UserService implements BaseUserService {
  final Client client;

  const UserService({required this.client});

  @override
  Future<Result<Iterable<User>, String>> getUsers() async {
    try {
      final response = await client.get(
        Uri.parse("https://api.github.com/users"),
      );

      if (response.statusCode == 200) {
        final parsedUsers = jsonDecode(response.body) as List;

        final users = parsedUsers.map((user) {
          return User.fromMap(user);
        }).toList();

        return Ok(users);
      }

      throw UserServiceError(response.body);
    } on UserServiceError catch (err) {
      return Err(err.message ?? "Unknown error occured!, try again");
    }
  }
}
