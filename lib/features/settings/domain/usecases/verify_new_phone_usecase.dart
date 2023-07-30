import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import 'package:makanvi_web/core/usecases/usecases.dart';

import '../repositories/setting_repository.dart';

class RequestPhoneOtpUsecase extends UseCase<String, phoneParams> {
  final SettingsRepository settingsRepository;

  RequestPhoneOtpUsecase({required this.settingsRepository});

  @override
  Future<Either<Failure, String>> call(phoneParams params) =>
      settingsRepository.requestPhoneOtp(params: params);
}

class phoneParams {
  final String phone;
  final String countryId;

  phoneParams({
    required this.phone,
    required this.countryId,
  });
}
