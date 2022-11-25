import 'dart:async';

import 'package:counter_app/shared/bloc/bloc.interface.dart';

class CounterBloc implements Bloc {
  final Stream<int> counter;
  final Sink<void> increment;

  const CounterBloc._({
    required this.counter,
    required this.increment,
  });

  @override
  void dispose() {
    increment.close();
  }

  factory CounterBloc() {
    final controller = StreamController<void>();
    int count = 0;

    final Stream<int> counter = controller.stream.map((_) {
      return ++count;
    });

    return CounterBloc._(
      counter: counter,
      increment: controller.sink,
    );
  }
}
