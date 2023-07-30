import 'package:get_it/get_it.dart';

import '../../../bloc/share_cubit/share_cubit.dart';
import '../../auth/presentation/cubit/change_name_rent_or_sell/change_name_rent_or_sell_cubit.dart';
import 'data/datasources/listings_remote_datesource.dart';
import 'data/repositories/listings_repository_imp.dart';
import 'domain/repositories/listings_repositories.dart';
import 'domain/usecases/close_property_usecase.dart';
import 'domain/usecases/direct_upgrade_usecase.dart';
import 'domain/usecases/edit_listing_usecase.dart';
import 'domain/usecases/get_listing_data_usecase.dart';
import 'domain/usecases/get_listings_use_case.dart';
import 'domain/usecases/rate_shotting_usecase.dart';
import 'presentation/cubit/add_listing_cubit/add_listings_cubit.dart';
import 'presentation/cubit/close_property_cubit/close_property_cubit.dart';
import 'presentation/cubit/direct_upgrade/direct_upgrade_cubit.dart';
import 'presentation/cubit/edit_property_cubit/edit_property_cubit.dart';
import 'presentation/cubit/get_listing_cubit/get_listing_cubit.dart';
import 'presentation/cubit/get_one_listing_cubit/get_one_listing_cubit.dart';
import 'presentation/cubit/rate_shotting_cubit/rate_shotting_cubit.dart';

Future<void> initListingsinjection(GetIt sl) async {
  //* cubit

  sl.registerFactory<AddListingsCubit>(() => AddListingsCubit(
        createListingUseCase: sl(),
        directUpgradeUseCase: sl(),
      ));
  // sl.registerFactory<ShareCubit>(() => ShareCubit());

  sl.registerFactory<GetListingCubit>(() => GetListingCubit(
        getListingUseCase: sl(),
      ));
  sl.registerFactory<ClosePropertyCubit>(() => ClosePropertyCubit(
        closePropertyUseCase: sl(),
      ));
  sl.registerFactory<EditPropertyCubit>(() => EditPropertyCubit(
        editListingDataUseCase: sl(),
        getPropartyDataUsecase: sl(),
      ));
  sl.registerFactory<DirectUpgradeCubit>(() => DirectUpgradeCubit(
        directUpgradeUseCase: sl(),
      ));
  sl.registerFactory<GetOneListingCubit>(() => GetOneListingCubit(
        getListingDataUseCase: sl(),
      ));

  sl.registerFactory<RateShottingCubit>(() => RateShottingCubit(
        ratingShootUseCase: sl(),
      ));
  sl.registerFactory<ChangeNameRentOrSellCubit>(
      () => ChangeNameRentOrSellCubit());
  // use cases
  sl.registerLazySingleton(() => GetListingUseCase(listingsRepository: sl()));
  sl.registerLazySingleton(
      () => DirectUpgradeUseCase(listingsRepository: sl()));
  sl.registerLazySingleton(
      () => ClosePropertyUseCase(listingsRepository: sl()));
  sl.registerLazySingleton(
      () => EditListingDataUseCase(listingsRepository: sl()));
  sl.registerLazySingleton(
      () => GetListingDataUseCase(listingsRepository: sl()));
  sl.registerLazySingleton(() => RatingShootUseCase(listingsRepository: sl()));

  //* Repository
  sl.registerLazySingleton<ListingsRepository>(
    () => ListingsRepositoryImpl(listingsDatasource: sl(), sl()),
  );

  //* Data sources
  sl.registerLazySingleton<ListingsDatasource>(
    () => ListingsDatasourceImpl(
      apiConsumer: sl(),
      // firebaseMessaging: sl(),
    ),
  );
}
