import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import 'package:makanvi_web/core/usecases/usecases.dart';

import '../../../auth/data/models/register_model.dart';
import '../repositories/setting_repository.dart';

class UpdatePhoneNumberUsecase
    extends UseCase<UserModel, UpdatePhoneNumberParams> {
  final SettingsRepository settingsRepository;

  UpdatePhoneNumberUsecase({required this.settingsRepository});

  @override
  Future<Either<Failure, UserModel>> call(UpdatePhoneNumberParams params) =>
      settingsRepository.updatePhone(params: params);
}

class UpdatePhoneNumberParams {
  final String phone;
  final String countryId;
  final String? otp;

  UpdatePhoneNumberParams(
      {required this.phone, required this.countryId, this.otp});
}
