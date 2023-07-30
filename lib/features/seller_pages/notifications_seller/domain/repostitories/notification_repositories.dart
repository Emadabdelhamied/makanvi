import 'package:dartz/dartz.dart';
import 'package:makanvi_web/features/seller_pages/notifications_seller/data/models/notification_model.dart';

import '../../../../../core/error/failures.dart';

abstract class NotificationRepository {
  Future<Either<Failure, NotificationModel>> getNotification();
  Future<Either<Failure, String>> deleteAllNotification();
}
