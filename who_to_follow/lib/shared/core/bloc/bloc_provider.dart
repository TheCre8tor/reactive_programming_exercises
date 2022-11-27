import 'package:flutter/material.dart';
import 'package:who_to_follow/shared/core/bloc/bloc_interface.dart';

class BlocProvider<T extends Bloc> extends StatefulWidget {
  final T bloc;
  final Widget child;

  const BlocProvider({
    super.key,
    required this.bloc,
    required this.child,
  });

  @override
  // ignore: library_private_types_in_public_api
  _BlocProviderState<T> createState() => _BlocProviderState<T>();

  static T of<T extends Bloc>(BuildContext context) {
    BlocProvider<T>? provider;
    provider = context.findAncestorWidgetOfExactType<BlocProvider<T>>();

    return provider!.bloc;
  }
}

class _BlocProviderState<T> extends State<BlocProvider<Bloc>> {
  @override
  void dispose() {
    super.dispose();
    widget.bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
