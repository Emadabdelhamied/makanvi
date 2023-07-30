import 'package:dartz/dartz.dart';
import 'package:makanvi_web/core/usecases/usecases.dart';
import 'package:makanvi_web/features/settings/data/models/profile_model.dart';
import '../../../../core/error/failures.dart';

import '../entities/profile_entity.dart';
import '../repositories/setting_repository.dart';

class GetProfileUsecase extends UseCase<ProfileModel, NoParams> {
  final SettingsRepository settingsRepository;

  GetProfileUsecase({required this.settingsRepository});

  @override
  Future<Either<Failure, ProfileModel>> call(NoParams params) =>
      settingsRepository.getProfile();
}
