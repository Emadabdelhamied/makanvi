import 'package:dartz/dartz.dart';

import 'package:makanvi_web/core/error/failures.dart';
import 'package:makanvi_web/core/usecases/usecases.dart';
import 'package:makanvi_web/features/auth/domain/entities/login_entitie.dart';
import 'package:makanvi_web/features/auth/domain/repositories/auth_repositories.dart';

class LoginUsecas extends UseCase<LoginEntity, LoginParams> {
  final AuthRepository authRepository;

  LoginUsecas({required this.authRepository});

  @override
  Future<Either<Failure, LoginEntity>> call(LoginParams params) =>
      authRepository.login(loginParams: params);
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({
    this.email = "",
    this.password = "",
  });

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
