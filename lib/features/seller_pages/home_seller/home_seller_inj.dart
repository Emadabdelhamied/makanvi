import 'package:get_it/get_it.dart';

import 'data/datasources/home_seller_remote_datesource.dart';
import 'data/repositories/home_seller_repository_imp.dart';
import 'domain/repositories/home_seller_repositories.dart';
import 'domain/usecases/home_seller_use_case.dart';
import 'presentation/cubit/home_cubit.dart';

Future<void> initHomeSellerinjection(GetIt sl) async {
  //* cubit

  sl.registerFactory<HomeSellerCubit>(
      () => HomeSellerCubit(homeSellerUseCase: sl()));

  // use cases
  sl.registerLazySingleton(() => HomeSellerUseCase(homeSellerRepository: sl()));

  //* Repository
  sl.registerLazySingleton<HomeSellerRepository>(
    () => HomeSellerRepositoryImpl(homeSellerDatasource: sl(), sl()),
  );

  //* Data sources
  sl.registerLazySingleton<HomeSellerDatasource>(
    () => HomeSellerDatasourceImpl(
      apiConsumer: sl(),
      // firebaseMessaging: sl(),
    ),
  );
}
