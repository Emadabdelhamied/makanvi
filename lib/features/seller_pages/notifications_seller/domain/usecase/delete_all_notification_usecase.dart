import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecases.dart';
import '../../data/models/notification_model.dart';
import '../repostitories/notification_repositories.dart';

class DeleteNotifcationAllUseCase extends UseCase<String, NoParams> {
  final NotificationRepository notificationRepository;

  DeleteNotifcationAllUseCase({
    required this.notificationRepository,
  });

  @override
  Future<Either<Failure, String>> call(NoParams parms) async {
    return await notificationRepository.deleteAllNotification();
  }
}
