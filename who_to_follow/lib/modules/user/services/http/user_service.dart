import 'dart:convert';

import 'package:flutter/foundation.dart' show immutable;
import 'package:who_to_follow/modules/user/domain/entities/user.dart';
import 'package:who_to_follow/modules/user/repositories/user_repository.error.dart';
import 'package:who_to_follow/modules/user/services/http/user_service.interface.dart';
import 'package:http/http.dart';

@immutable
class UserService implements BaseUserService {
  final Client client;

  const UserService({required this.client});

  @override
  Future<Iterable<User>> getUsers() async {
    final response = await client.get(
      Uri.parse("https://api.github.com/users"),
    );

    if (response.statusCode == 200) {
      final parsedUsers = jsonDecode(response.body) as List;

      final users = parsedUsers.map((user) {
        return User.fromMap(user);
      }).toList();

      return users;
    }

    throw UserRepositoryException(response.body);
  }
}