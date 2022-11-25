import 'package:counter_app/screens/counter/bloc/counter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Counter", () {
    test("should increment when a number is passed into the sink", () {
      // arrange ->
      final counterBloc = CounterBloc();

      // act ->
      counterBloc.increment.add(null);
      counterBloc.increment.add(null);
      counterBloc.increment.add(null);
      counterBloc.increment.add(null);

      // dispose the sink ->
      counterBloc.dispose();

      // assert ->
      expect(counterBloc.counter, emitsInOrder([1, 2, 3, 4, emitsDone]));
    });
  });
}
