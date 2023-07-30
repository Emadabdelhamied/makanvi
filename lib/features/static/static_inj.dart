import 'package:get_it/get_it.dart';

import 'data/datasources/static_datasource.dart';
import 'data/repositories/static_repository_imp.dart';
import 'domain/repositories/static_repository.dart';
import 'domain/usecases/abou_us_usecase.dart';
import 'domain/usecases/become_partner.dart';
import 'domain/usecases/contact_us.dart';
import 'domain/usecases/privacy_and_policy_use_case.dart';
import 'domain/usecases/terms_and_conditions_usecase.dart';
import 'presentation/cubit/static_cubit.dart';

Future<void> initStaticInjection(GetIt sl) async {
  ////* cubit

  sl.registerFactory(() => StaticCubit(
        aboutUsUseCase: sl(),
        privacyAndPolicyUseCase: sl(),
        termsAndConditionsUseCase: sl(),
        contactWithUsUseCase: sl(),
      ));

  //* Use cases
  sl.registerLazySingleton(
    () => BecomePartenerUseCase(staticRepository: sl()),
  );
  sl.registerLazySingleton(
    () => ContactWithUsUseCase(staticRepository: sl()),
  );
  sl.registerLazySingleton(
    () => AboutUsUseCase(staticRepository: sl()),
  );
  sl.registerLazySingleton(
    () => TermsAndConditionsUseCase(staticRepository: sl()),
  );
  sl.registerLazySingleton(
    () => PrivacyAndPolicyUseCase(staticRepository: sl()),
  );
  //* Repository
  sl.registerLazySingleton<StaticRepository>(
    () => StaticRepositoryImp(
      appRepository: sl(),
      staticDatasource: sl(),
    ),
  );

  //* Data sources
  sl.registerLazySingleton<StaticDatasource>(
    () => StaticDatasourceImp(
      apiConsumer: sl(),
    ),
  );
}
