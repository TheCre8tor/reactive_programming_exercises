import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart' show immutable;
import 'package:ruqe/ruqe.dart';
import 'package:rxdart/rxdart.dart';
import 'package:who_to_follow/modules/user/domain/entities/user.dart';
import 'package:who_to_follow/shared/core/bloc/bloc_interface.dart';
import 'package:who_to_follow/shared/core/usecases/usecases.dart';

@immutable
class UserSuggestionBloc implements Bloc {
  final Stream<Iterable<User>> users;
  final StreamSink<None> refreshedUsers;

  final Stream<User> user1;
  final Stream<User> user2;
  final Stream<User> user3;
  final StreamSink<None> closeUser1;
  final StreamSink<None> closeUser2;
  final StreamSink<None> closeUser3;

  @override
  void dispose() {
    refreshedUsers.close();
    closeUser1.close();
    closeUser2.close();
    closeUser3.close();
  }

  const UserSuggestionBloc._({
    required this.users,
    required this.refreshedUsers,
    required this.user1,
    required this.user2,
    required this.user3,
    required this.closeUser1,
    required this.closeUser2,
    required this.closeUser3,
  });

  factory UserSuggestionBloc({
    required Usecases<Iterable<User>, Option> usecase,
  }) {
    final requestOnRefreshStream = BehaviorSubject<None>();
    final suggestion1Stream = BehaviorSubject<None>();
    final suggestion2Stream = BehaviorSubject<None>();
    final suggestion3Stream = BehaviorSubject<None>();

    final Stream<Iterable<User>> refreshStream =
        requestOnRefreshStream.switchMap((_) {
      return Rx.fromCallable(() async {
        final random = Random().nextInt(100);

        final response = await usecase(Some(random));

        if (response.isOk()) {
          return response.ok().unwrap();
        } else {
          requestOnRefreshStream.addError(response.err().unwrap());
          return [];
        }
      });
    });

    final Stream<User> user1 = _createSuggestion(
      requestOnRefreshStream,
      suggestion1Stream,
      refreshStream,
    );

    final Stream<User> user2 = _createSuggestion(
      requestOnRefreshStream,
      suggestion2Stream,
      refreshStream,
    );

    final Stream<User> user3 = _createSuggestion(
      requestOnRefreshStream,
      suggestion3Stream,
      refreshStream,
    );

    return UserSuggestionBloc._(
      users: refreshStream,
      refreshedUsers: requestOnRefreshStream.sink,
      user1: user1,
      user2: user2,
      user3: user3,
      closeUser1: suggestion1Stream.sink,
      closeUser2: suggestion2Stream.sink,
      closeUser3: suggestion3Stream.sink,
    );
  }

  static Stream<User> _createSuggestion(
    BehaviorSubject<None<dynamic>> requestOnRefreshStream,
    BehaviorSubject<None<dynamic>> suggestion1Stream,
    Stream<Iterable<User>> refreshStream,
  ) {
    return suggestion1Stream.stream.switchMap((_) {
      requestOnRefreshStream.sink.add(const None());

      return Rx.combineLatest([refreshStream], (values) {
        final listUsers = values[0] as List<User>;

        final random = Random().nextDouble() * listUsers.length;

        return listUsers[random.floor()];
      });
    });
  }
}
