// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import '../util/api_basehelper.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failure {
  final String message;
  final CodeStatus code;
  ServerFailure({
    required this.message,
    this.code = CodeStatus.defaultCode,
  });
}

class CacheFailure extends Failure {}

class AuthFailure extends Failure {
  final String message;
  AuthFailure({required this.message});
}

class NoCachedUserFailure extends Failure {}

class ResetPasswordFailure extends Failure {}

class StatusFailure extends Failure {
  final String message;
  StatusFailure({required this.message});
}

class FirebaseFailure extends Failure {
  final String message;
  FirebaseFailure({required this.message});
}
