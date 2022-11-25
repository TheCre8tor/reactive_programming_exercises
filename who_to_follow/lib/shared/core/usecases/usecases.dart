import 'package:ruqe/ruqe.dart';

abstract class Usecases<T, P> {
  Future<Result<T, String>> call(P params);
}
