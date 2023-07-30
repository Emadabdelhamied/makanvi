import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import 'package:makanvi_web/core/usecases/usecases.dart';

import '../repositories/setting_repository.dart';

class SwitchUserUsecase extends UseCase<String, NoParams> {
  final SettingsRepository settingsRepository;

  SwitchUserUsecase({required this.settingsRepository});

  @override
  Future<Either<Failure, String>> call(NoParams params) =>
      settingsRepository.switchUserAccount();
}
