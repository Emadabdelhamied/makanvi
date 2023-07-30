import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import 'package:makanvi_web/core/usecases/usecases.dart';

import '../repositories/setting_repository.dart';

class NotificationStatusUsecase
    extends UseCase<String, NotificationStatusParams> {
  final SettingsRepository settingsRepository;

  NotificationStatusUsecase({required this.settingsRepository});

  @override
  Future<Either<Failure, String>> call(NotificationStatusParams params) =>
      settingsRepository.notificationStatus(params: params);
}

class NotificationStatusParams {
  final String status;
  NotificationStatusParams({
    required this.status,
  });
}
