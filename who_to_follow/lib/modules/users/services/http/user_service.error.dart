import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserServiceError extends Equatable implements Exception {
  final String? message;

  UserServiceError([String? error])
      : message = jsonDecode(error ?? "")["message"];

  @override
  List<Object?> get props => [message];
}
