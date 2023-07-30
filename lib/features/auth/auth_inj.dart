import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../injection_container.dart';
import '../seller_pages/listining_seller/domain/usecases/create_listings_usecase.dart';
import 'data/datasources/remote_datasource/auth_remotedatasource.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/repositories/auth_repositories.dart';
import 'domain/usecases/apple_usecase.dart';
import 'domain/usecases/complete_register_usecase.dart';
import 'domain/usecases/countery_usecase.dart';
import 'domain/usecases/get_proparty_usecase.dart';
import 'domain/usecases/google_usecase.dart';
import 'domain/usecases/login_usecase.dart';
import 'domain/usecases/logout_usecase.dart';
import 'domain/usecases/on_boardin_usecase.dart';
import 'domain/usecases/register_usecase.dart';
import 'domain/usecases/send_otp_phone_usecase.dart';
import 'domain/usecases/update_location_usecase.dart';
import 'domain/usecases/verify_otp_usecase.dart';
import 'presentation/cubit/add_property/add_property_cubit.dart';
import 'presentation/cubit/auth_cubit.dart';
import 'presentation/cubit/complete_register/complete_register_cubit.dart';
import 'presentation/cubit/countery_cubit/counery_cubit.dart';
import 'presentation/cubit/login_cubit/login_cubit.dart';
import 'presentation/cubit/on_boarding_cubit/on_boarding_cubit.dart';
import 'presentation/cubit/pincode_cubit/pincode_cubit.dart';
import 'presentation/cubit/sign_up_cubit/signup_cubit.dart';
import 'presentation/cubit/update_location/update_location_cubit.dart';
import 'presentation/cubit/verfiy_phone_cubit/verfiy_phone_cubit.dart';

Future<void> initAuthinjection(GetIt sl) async {
  //* cubit

  sl.registerFactory<OnBoardingCubit>(() => OnBoardingCubit(
      getOnBoardingDataUsecase: sl(), getCounterySelectUsecase: sl()));
  sl.registerFactory<AddPropertyCubit>(() => AddPropertyCubit(
      getPropartyDataUsecase: sl(), createListingUseCase: sl()));
  sl.registerFactory<SignupCubit>(() => SignupCubit(registerUseCase: sl()));
  sl.registerFactory<CompleteRegisterCubit>(
      () => CompleteRegisterCubit(completeRegisterUsecase: sl()));

  sl.registerFactory<VerfiyPhoneCubit>(
      () => VerfiyPhoneCubit(sendOtpPhoneUseCase: sl()));
  sl.registerFactory<LoginCubit>(() => LoginCubit(
        loginUsecas: sl(),
      ));
  sl.registerFactory<CouneryCubit>(() => CouneryCubit(
        getCounterySelectUsecase: sl(),
      ));
  sl.registerFactory<PincodeCubit>(
    () => PincodeCubit(verifyOtpUsecase: sl(), createListingUseCase: sl()),
  );
  sl.registerFactory<UpdateLocationCubit>(
    () => UpdateLocationCubit(updateLocationUsecase: sl()),
  );
  sl.registerFactory(() => AuthCubit(
      googleSignInUsecase: sl(),
      appleSignInUsecase: sl(),
      logoutUsecase: sl(),
      createListingUseCase: sl(),
      updateLocationUsecase: sl()));
  // use cases
  sl.registerLazySingleton(() => GetOnBoardingDataUsecase(repository: sl()));
  sl.registerLazySingleton(() => GetCounterySelectUsecase(repository: sl()));
  sl.registerLazySingleton(() => GetPropartyDataUsecase(repository: sl()));
  sl.registerLazySingleton(() => GoogleSignInUsecase(authRepository: sl()));
  sl.registerLazySingleton(() => AppleSignInUsecase(authRepository: sl()));
  sl.registerLazySingleton(() => LogoutUsecase(repository: sl()));
  sl.registerLazySingleton(() => RegisterUsecas(authRepository: sl()));
  sl.registerLazySingleton(() => SendOtpPhoneUseCase(repository: sl()));
  sl.registerLazySingleton(() => VerifyOtpUsecase(authRepository: sl()));
  sl.registerLazySingleton(() => LoginUsecas(authRepository: sl()));
  sl.registerLazySingleton(() => CompleteRegisterUsecase(authRepository: sl()));
  sl.registerLazySingleton(() => UpdateLocationUsecase(authRepository: sl()));
  sl.registerLazySingleton(
      () => CreateListingUseCase(listingsRepository: sl()));

  //* Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authRemoteDatasource: sl(), sl()),
  );

  //* Data sources
  sl.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(
      apiConsumer: sl(),
      // firebaseMessaging: sl(),
    ),
  );
}

List<BlocProvider> onBoardingBlocs(BuildContext context) => [
      BlocProvider<OnBoardingCubit>(
          create: (BuildContext context) =>
              sl<OnBoardingCubit>()..fGetOnBoardingData()),
      BlocProvider<AddPropertyCubit>(
          create: (BuildContext context) => sl<AddPropertyCubit>()),
      BlocProvider<CouneryCubit>(
          create: (BuildContext context) =>
              sl<CouneryCubit>()..fGetAllCountery()),
    ];
