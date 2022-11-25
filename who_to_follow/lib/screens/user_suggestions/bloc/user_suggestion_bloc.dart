import 'dart:async';

import 'package:flutter/foundation.dart' show immutable;
import 'package:ruqe/ruqe.dart';
import 'package:rxdart/rxdart.dart';
import 'package:who_to_follow/modules/user/domain/entities/user.dart';
import 'package:who_to_follow/shared/core/bloc/bloc_interface.dart';
import 'package:who_to_follow/shared/core/usecases/usecases.dart';

@immutable
class UserSuggestionBloc implements Bloc {
  final Stream<Iterable<User>> users;
  final StreamSink<void> getUsers;

  @override
  void dispose() {
    getUsers.close();
  }

  const UserSuggestionBloc._({
    required this.users,
    required this.getUsers,
  });

  factory UserSuggestionBloc({
    required Usecases<Iterable<User>, None> usecase,
  }) {
    final controller = BehaviorSubject();

    final Stream<Iterable<User>> users =
        controller.stream.distinct().switchMap((_) {
      return Rx.fromCallable(() async {
        final response = await usecase(const None());

        if (response.isOk()) {
          return response.ok().unwrap();
        } else {
          controller.addError(response.err().unwrap());
          return [];
        }
      });
    });

    return UserSuggestionBloc._(
      users: users,
      getUsers: controller.sink,
    );
  }
}
