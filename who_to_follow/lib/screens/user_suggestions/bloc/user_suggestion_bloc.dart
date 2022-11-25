import 'package:flutter/foundation.dart' show immutable;
import 'package:ruqe/ruqe.dart';
import 'package:rxdart/rxdart.dart';
import 'package:who_to_follow/modules/user/domain/entities/user.dart';
import 'package:who_to_follow/shared/core/bloc/bloc_interface.dart';
import 'package:who_to_follow/shared/core/usecases/usecases.dart';

@immutable
class UserSuggestionBloc implements Bloc {
  final Usecases<Iterable<User>, None> _usecase;
  final Stream<List<User>> users;
  final Sink<None> getUsers;

  @override
  void dispose() {
    getUsers.close();
  }

  const UserSuggestionBloc._({
    required Usecases<Iterable<User>, None> usecase,
    required this.users,
    required this.getUsers,
  }) : _usecase = usecase;

  factory UserSuggestionBloc({
    required Usecases<Iterable<User>, None> usecase,
  }) {
    final controller = BehaviorSubject.seeded(const <User>[]);

    final Stream<List<User>> users = controller.stream.distinct().switchMap((value) => null)
  }
}
