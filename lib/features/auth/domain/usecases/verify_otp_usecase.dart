import 'package:dartz/dartz.dart';

import 'package:makanvi_web/core/error/failures.dart';
import 'package:makanvi_web/core/usecases/usecases.dart';
import 'package:makanvi_web/features/auth/data/models/vefiy_otp_model.dart';
import 'package:makanvi_web/features/auth/domain/repositories/auth_repositories.dart';

class VerifyOtpUsecase extends UseCase<VerfiyOtpModel, VerifyOtpParams> {
  final AuthRepository authRepository;

  VerifyOtpUsecase({required this.authRepository});

  @override
  Future<Either<Failure, VerfiyOtpModel>> call(VerifyOtpParams params) =>
      authRepository.verifyOtp(verifyOtpParams: params);
}

class VerifyOtpParams {
  final String mobileConteryId;
  final String mobileNumber;
  final String otp;

  VerifyOtpParams({
    this.mobileConteryId = "",
    this.mobileNumber = "",
    this.otp = "",
  });

  Map<String, dynamic> toJson() => {
        "mobile_country_id": mobileConteryId,
        "pasmobile_numbersword": mobileNumber,
        "otp": otp,
      };
}
