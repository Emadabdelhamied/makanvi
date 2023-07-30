import 'package:get_it/get_it.dart';

import 'data/datasource/notification_datasource.dart';
import 'data/repostitories/notification_repositories_imp.dart';
import 'domain/repostitories/notification_repositories.dart';
import 'domain/usecase/delete_all_notification_usecase.dart';
import 'domain/usecase/get_notification_usecase.dart';
import 'presentation/cubit/notification_cubit/notification_cubit.dart';

Future<void> initNotificationinjection(GetIt sl) async {
  //* cubit

  sl.registerFactory<NotificationSellerCubit>(() => NotificationSellerCubit(
      getNotificationAllUseCase: sl(), deleteNotifcationAllUseCase: sl()));

  // use cases
  sl.registerLazySingleton(
      () => GetNotificationAllUseCase(notificationRepository: sl()));

  sl.registerLazySingleton(
      () => DeleteNotifcationAllUseCase(notificationRepository: sl()));

  //* Repository
  sl.registerLazySingleton<NotificationRepository>(
    () => NotificationRepositoryImpl(notificationDatasource: sl(), sl()),
  );

  //* Data sources
  sl.registerLazySingleton<NotificationDatasource>(
    () => NotificationDatasourceImpl(
      apiConsumer: sl(),
      // firebaseMessaging: sl(),
    ),
  );
}
