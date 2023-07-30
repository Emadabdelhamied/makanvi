import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecases.dart';
import '../../data/models/notification_model.dart';
import '../repostitories/notification_repositories.dart';

class GetNotificationAllUseCase extends UseCase<NotificationModel, NoParams> {
  final NotificationRepository notificationRepository;

  GetNotificationAllUseCase({
    required this.notificationRepository,
  });

  @override
  Future<Either<Failure, NotificationModel>> call(NoParams parms) async {
    return await notificationRepository.getNotification();
  }
}
