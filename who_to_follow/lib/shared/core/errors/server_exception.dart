import 'dart:convert';

import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  final String? message;

  ServerException([String? error])
      : message = jsonDecode(error ?? "")["message"];

  @override
  List<Object?> get props => [message];
}
