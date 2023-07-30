import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import 'package:makanvi_web/core/usecases/usecases.dart';

import '../repositories/setting_repository.dart';

class VerifyPasswordOtpUsecase extends UseCase<String, VerifyParams> {
  final SettingsRepository settingsRepository;

  VerifyPasswordOtpUsecase({required this.settingsRepository});

  @override
  Future<Either<Failure, String>> call(VerifyParams params) =>
      settingsRepository.verifyOtp(params: params);
}

class VerifyParams {
  final String email;
  final String otp;
  final String code;
  VerifyParams({
    required this.email,
    required this.otp,
    required this.code,
  });
}
