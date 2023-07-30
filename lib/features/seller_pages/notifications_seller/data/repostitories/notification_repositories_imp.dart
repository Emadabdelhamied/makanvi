import 'package:dartz/dartz.dart';

import '../../../../../core/app/app_repository.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../domain/repostitories/notification_repositories.dart';
import '../datasource/notification_datasource.dart';
import '../models/notification_model.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationDatasource notificationDatasource;
  final AppRepository appRepository;
  NotificationRepositoryImpl(this.appRepository,
      {required this.notificationDatasource});

  @override
  Future<Either<Failure, NotificationModel>> getNotification() async {
    try {
      final notification = await notificationDatasource.getNotification(
        token: appRepository.loadAppData()!.token.toString(),
      );

      // await local.listingsDatasource(token: user.body.accessToken.toString());
      return Right(notification);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> deleteAllNotification() async {
    try {
      final deleteNotificatin =
          await notificationDatasource.deleteAllNotification(
        token: appRepository.loadAppData()!.token.toString(),
      );

      // await local.listingsDatasource(token: user.body.accessToken.toString());
      return Right(deleteNotificatin);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
