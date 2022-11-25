import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserRepositoryError extends Equatable implements Exception {
  final String? message;

  UserRepositoryError([String? error])
      : message = jsonDecode(error ?? "")["message"];

  @override
  List<Object?> get props => [message];
}
