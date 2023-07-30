import 'package:dartz/dartz.dart';
import 'package:makanvi_web/core/usecases/usecases.dart';
import '../../../../core/error/failures.dart';
import '../repositories/setting_repository.dart';

class CancelSubscriptionRequestUseCase
    extends UseCase<String, CancelSubscriptionParams> {
  final SettingsRepository settingsRepository;

  CancelSubscriptionRequestUseCase({required this.settingsRepository});

  @override
  Future<Either<Failure, String>> call(CancelSubscriptionParams params) =>
      settingsRepository.cancelSubscriptionRequest(params: params);
}

class CancelSubscriptionParams {
  final int pakageId;

  CancelSubscriptionParams({required this.pakageId});
}
