import 'package:http/http.dart';
import 'package:kiwi/kiwi.dart';
import 'package:who_to_follow/modules/user/repositories/user_repository.dart';
import 'package:who_to_follow/modules/user/services/http/user_service.dart';
import 'package:who_to_follow/modules/user/usecases/get_users.dart';
import 'package:who_to_follow/screens/user_suggestion/bloc/user_suggestion_bloc.dart';

final kiwiContainer = KiwiContainer();

Future<void> init() async {
  kiwiContainer.registerFactory((container) {
    return UserSuggestionBloc(usecase: container.resolve<GetUsers>());
  });

  kiwiContainer.registerSingleton((container) {
    return GetUsers(repository: container.resolve<UserRepository>());
  });

  kiwiContainer.registerSingleton((container) {
    return UserRepository(service: container.resolve<UserService>());
  });

  kiwiContainer.registerSingleton((container) {
    return UserService(client: container.resolve<Client>());
  });

  kiwiContainer.registerSingleton((container) => Client());
}
