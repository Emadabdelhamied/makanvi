import 'package:get_it/get_it.dart';
import 'package:makanvi_web/features/seller_pages/payment/presentation/cubit/payment_info/payment_info_cubit.dart';

import 'data/datasource/payment_datasource.dart';
import 'data/repostitories/payment_repositories_impl.dart';
import 'domain/repositories/payment_repositories.dart';
import 'domain/usecase/add_payment_intent_usecase.dart';
import 'domain/usecase/adding_card_intent_usecase.dart';
import 'domain/usecase/agancy_create_usecase.dart';
import 'domain/usecase/delete_card_usecase.dart';
import 'domain/usecase/get_package_usecase.dart';
import 'domain/usecase/get_payment_info_usecase.dart';
import 'domain/usecase/select_date_usecase.dart';
import 'presentation/cubit/agancy_create/agancy_create_cubit.dart';
import 'presentation/cubit/card_payment/card_payment_cubit.dart';
import 'presentation/cubit/get_package_payment_cubit/get_package_payment_cubit.dart';
import 'presentation/cubit/payment_intent/payment_intent_cubit.dart';
import 'presentation/cubit/select_date_cubit/select_date_cubit.dart';

Future<void> initPaymentinjection(GetIt sl) async {
  //* cubit

  sl.registerFactory<GetPackagePaymentCubit>(() => GetPackagePaymentCubit(
        getPaymentPackageUseCase: sl(),
      ));
  sl.registerFactory<PaymentInfoCubit>(() => PaymentInfoCubit(
        getPaymentInfoUseCase: sl(),
      ));

  sl.registerFactory<CardPaymentCubit>(() =>
      CardPaymentCubit(adddCardIntentUseCase: sl(), deleteCardUseCase: sl()));
  sl.registerFactory<PaymentIntentCubit>(() => PaymentIntentCubit(
        addPaymentIntentUseCase: sl(),
      ));
  sl.registerFactory<SelectDateCubit>(() => SelectDateCubit(
        selectDateUseCase: sl(),
      ));
  sl.registerFactory<AgancyCreateCubit>(() => AgancyCreateCubit(
        agancyCreateUseCase: sl(),
      ));
  // use cases
  sl.registerLazySingleton(
      () => GetPaymentPackageUseCase(paymentRepository: sl()));
  sl.registerLazySingleton(
      () => GetPaymentInfoUseCase(paymentRepository: sl()));

  sl.registerLazySingleton(
      () => AdddCardIntentUseCase(paymentRepository: sl()));

  sl.registerLazySingleton(() => DeleteCardUseCase(paymentRepository: sl()));
  sl.registerLazySingleton(
      () => AddPaymentIntentUseCase(paymentRepository: sl()));

  sl.registerLazySingleton(() => SelectDateUseCase(paymentRepository: sl()));

  sl.registerLazySingleton(() => AgancyCreateUseCase(paymentRepository: sl()));
  //* Repository
  sl.registerLazySingleton<PaymentRepository>(
    () => PayumentRepositoryImpl(paymentDatasource: sl(), sl()),
  );

  //* Data sources
  sl.registerLazySingleton<PaymentDatasource>(
    () => PaymentDatasourceImpl(
      apiConsumer: sl(),
      // firebaseMessaging: sl(),
    ),
  );
}
