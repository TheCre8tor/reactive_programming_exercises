import 'package:flutter/material.dart';
import 'package:ruqe/ruqe.dart';
import 'package:who_to_follow/dependency_injection.dart';
import 'package:who_to_follow/screens/user_suggestion/bloc/user_suggestion_bloc.dart';
import 'package:who_to_follow/screens/user_suggestion/widgets/suggested_user.dart';
import 'package:who_to_follow/shared/core/bloc/bloc_provider.dart';

part 'suggestion_view.dart';

class SuggestionPage extends StatelessWidget {
  const SuggestionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: kiwiContainer<UserSuggestionBloc>(),
      child: const _SuggestionView(),
    );
  }
}
