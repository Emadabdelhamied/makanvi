import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import 'package:makanvi_web/core/usecases/usecases.dart';

import '../repositories/setting_repository.dart';

class RequestOtpUsecase extends UseCase<String, OtpParams> {
  final SettingsRepository settingsRepository;

  RequestOtpUsecase({required this.settingsRepository});

  @override
  Future<Either<Failure, String>> call(OtpParams params) =>
      settingsRepository.requestOtp(params: params);
}

class OtpParams {
  final String phone;
  final String code;

  OtpParams({
    required this.phone,
    required this.code,
  });
}
