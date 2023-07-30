import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../data/models/send_otp_model.dart';
import '../repositories/auth_repositories.dart';

class SendOtpPhoneUseCase extends UseCase<SendOtpModel, SendOtpParams> {
  final AuthRepository repository;
  SendOtpPhoneUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, SendOtpModel>> call(
    SendOtpParams params,
  ) async {
    return await repository.sendOtpPhone(sendOtpParams: params);
  }
}

class SendOtpParams {
  final String mobileConteryId;
  final String mobileNumber;
  final int? validUniq;

  SendOtpParams({
    this.mobileConteryId = "",
    this.mobileNumber = "",
    this.validUniq,
  });

  Map<String, dynamic> toJson() => {
        "mobile_country_id": mobileConteryId,
        "pasmobile_numbersword": mobileNumber,
      };
}
