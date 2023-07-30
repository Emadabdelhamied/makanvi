import 'package:get_it/get_it.dart';
import 'package:makanvi_web/features/settings/presentation/cubit/cancel_subscription_cubit/cancel_subscription_cubit.dart';

import 'data/datasources/setting_datasource.dart';
import 'data/repositories/setting_repository_imp.dart';
import 'domain/repositories/setting_repository.dart';
import 'domain/usecases/cancel_subscription_usecase.dart';
import 'domain/usecases/delete_account_usecase.dart';
import 'domain/usecases/get_profile_usecase.dart';
import 'domain/usecases/notification_status_usecase.dart';
import 'domain/usecases/request_otp_usecase.dart';
import 'domain/usecases/reset_password_usecase.dart';
import 'domain/usecases/switch_user_usecase.dart';
import 'domain/usecases/update_phone_usecase.dart';
import 'domain/usecases/update_profile_usecase.dart';
import 'domain/usecases/verify_new_phone_usecase.dart';
import 'domain/usecases/verify_otp_usecase.dart';
import 'presentation/cubit/delete_account_cubit/delete_account_cubit.dart';
import 'presentation/cubit/profile_cubit/profile_cubit.dart';
import 'presentation/cubit/reset_password/reset_password_cubit.dart';
import 'presentation/cubit/switch_user_cubit/switch_user_cubit.dart';
import 'presentation/cubit/update_phone/update_phone_cubit.dart';
import 'presentation/cubit/update_profile/update_profile_cubit.dart';

Future<void> initSettingInjection(GetIt sl) async {
  //* cubit

  sl.registerFactory(
    () => SettingsCubit(
      requestOtpUsecase: sl(),
      resetPasswordUsecase: sl(),
      verifyOtpUsecase: sl(),
    ),
  );

  sl.registerFactory(
    () => ProfileCubit(
      getProfileUsecase: sl(),
    ),
  );
  sl.registerFactory(
    () => CancelSubscriptionCubit(
      cancelSubscriptionRequestUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => UpdateProfileCubit(updateProfileUsecase: sl()),
  );
  sl.registerFactory(
    () => UpdatePhoneCubit(
        updatePhoneNumberUsecase: sl(), requestPhoneOtpUsecase: sl()),
  );

  sl.registerFactory(
    () => DeleteAccountCubit(deleteAccountUseCase: sl()),
  );

  sl.registerFactory(
    () => SwitchUserCubit(switchUserUsecase: sl()),
  );
  //* Use cases

  sl.registerLazySingleton(
    () => DeleteAccountUseCase(
      settingsRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => RequestPhoneOtpUsecase(
      settingsRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => RequestOtpUsecase(
      settingsRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => VerifyPasswordOtpUsecase(
      settingsRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => ResetPasswordUsecase(
      settingsRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => NotificationStatusUsecase(
      settingsRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => GetProfileUsecase(
      settingsRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => UpdateProfileUsecase(
      settingsRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => UpdatePhoneNumberUsecase(
      settingsRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => CancelSubscriptionRequestUseCase(
      settingsRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => SwitchUserUsecase(
      settingsRepository: sl(),
    ),
  );
  //* Repository
  sl.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImp(
      appRepository: sl(),
      settingDatasource: sl(),
    ),
  );

  //* Data sources
  sl.registerLazySingleton<SettingDatasource>(
    () => SettingDatasourceImp(
      apiConsumer: sl(),
    ),
  );
}
