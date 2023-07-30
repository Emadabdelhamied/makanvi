import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import 'package:makanvi_web/core/usecases/usecases.dart';

import '../repositories/setting_repository.dart';

class ResetPasswordUsecase extends UseCase<String, ResetPasswordParams> {
  final SettingsRepository settingsRepository;

  ResetPasswordUsecase({required this.settingsRepository});

  @override
  Future<Either<Failure, String>> call(ResetPasswordParams params) =>
      settingsRepository.resetPasswordOtp(params: params);
}

class ResetPasswordParams {
  final String password;
  final String confirmedPassword;
  final String token;
  ResetPasswordParams({
    required this.password,
    required this.confirmedPassword,
    required this.token,
  });
}
