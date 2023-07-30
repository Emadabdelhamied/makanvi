import 'package:dartz/dartz.dart';
import 'package:makanvi_web/core/error/failures.dart';

import 'package:makanvi_web/core/usecases/usecases.dart';
import 'package:makanvi_web/features/auth/domain/repositories/auth_repositories.dart';
import '../entities/login_entitie.dart';
import 'google_usecase.dart';

class AppleSignInUsecase extends UseCase<LoginEntity, GoogleSignInParams> {
  final AuthRepository authRepository;

  AppleSignInUsecase({required this.authRepository});

  @override
  Future<Either<Failure, LoginEntity>> call(GoogleSignInParams params) =>
      authRepository.appleSignIn(googleSignInParams: params);
}
