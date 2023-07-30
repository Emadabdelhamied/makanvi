import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/login_entitie.dart';
import '../repositories/auth_repositories.dart';

class GoogleSignInUsecase extends UseCase<LoginEntity, GoogleSignInParams> {
  final AuthRepository authRepository;

  GoogleSignInUsecase({required this.authRepository});

  @override
  Future<Either<Failure, LoginEntity>> call(GoogleSignInParams params) =>
      authRepository.googleSignIn(googleSignInParams: params);
}

class GoogleSignInParams {
  final String token;
  final String accountMode;
  final String lang;
  final String codnteryId;

  GoogleSignInParams(
      {this.token = "",
      this.accountMode = "",
      this.lang = "",
      this.codnteryId = ""});
}
