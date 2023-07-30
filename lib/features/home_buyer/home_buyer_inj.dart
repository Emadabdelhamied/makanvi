import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:makanvi_web/features/home_buyer/domain/usecase/search_and_filter_usecase.dart';
import 'package:makanvi_web/features/home_buyer/presentation/cubit/project_details_cubit/project_details_cubit.dart';
import 'package:makanvi_web/features/home_buyer/presentation/cubit/search_cubit/search_cubit.dart';

import '../../injection_container.dart';
import 'data/datasource/home_buyer_datasource.dart';
import 'data/repostitories/home_buyer_repositories_impl.dart';
import 'domain/repositories/home_buyer_repositories.dart';
import 'domain/usecase/get_feature_all_usecase.dart';
import 'domain/usecase/get_home_buyer_usecase.dart';
import 'domain/usecase/get_popular_location_usecase.dart';
import 'domain/usecase/get_project_details_usecase.dart';
import 'domain/usecase/get_recntly_all_usecase.dart';
import 'presentation/cubit/feature_all_cubit/feature_all_cubit.dart';
import 'presentation/cubit/home_buyer_cubit/home_buyer_cubit.dart';
import 'presentation/cubit/popular_location_cubit/popular_location_cubit.dart';
import 'presentation/cubit/recently_all_cubit/recently_all_cubit.dart';

Future<void> initHomeBuyerinjection(GetIt sl) async {
  //* cubit

  sl.registerFactory<HomeBuyerCubit>(
      () => HomeBuyerCubit(getHomeBuyerUseCase: sl()));
  sl.registerFactory<ProjectDetailsCubit>(
      () => ProjectDetailsCubit(getProjectUseCase: sl()));
  sl.registerFactory<SearchCubit>(
      () => SearchCubit(getSearchUseCase: sl(), getPropartyDataUsecase: sl()));

  sl.registerFactory<PopularLocationCubit>(
      () => PopularLocationCubit(getPopularLocationUseCase: sl()));
  sl.registerFactory<FeatureAllCubit>(
      () => FeatureAllCubit(getFeatureAllUseCase: sl()));
  sl.registerFactory<RecentlyAllCubit>(
      () => RecentlyAllCubit(getRecentlyAllUseCase: sl()));

  // use cases
  sl.registerLazySingleton(
      () => GetHomeBuyerUseCase(homeBuyerRepository: sl()));
  sl.registerLazySingleton(() => GetProjectUseCase(homeBuyerRepository: sl()));

  sl.registerLazySingleton(
      () => GetPopularLocationUseCase(homeBuyerRepository: sl()));
  sl.registerLazySingleton(() => GetSearchUseCase(homeBuyerRepository: sl()));

  sl.registerLazySingleton(
      () => GetFeatureAllUseCase(homeBuyerRepository: sl()));

  sl.registerLazySingleton(
      () => GetRecentlyAllUseCase(homeBuyerRepository: sl()));

  //* Repository
  sl.registerLazySingleton<HomeBuyerRepository>(
    () => HomeBuyerRepositoryImpl(homeBuyerDatasource: sl(), sl()),
  );

  //* Data sources
  sl.registerLazySingleton<HomeBuyerDatasource>(
    () => HomeBuyerDatasourceImpl(
      apiConsumer: sl(),
      // firebaseMessaging: sl(),
    ),
  );
}

List<BlocProvider> appHomeBlocs(BuildContext context) => [
      BlocProvider<SearchCubit>(
          create: (BuildContext context) => sl<SearchCubit>()),
      BlocProvider<FeatureAllCubit>(
          create: (BuildContext context) => sl<FeatureAllCubit>()),
      BlocProvider<PopularLocationCubit>(
          create: (BuildContext context) => sl<PopularLocationCubit>()),
      BlocProvider<RecentlyAllCubit>(
          create: (BuildContext context) => sl<RecentlyAllCubit>()),
      // BlocProvider<ShareCubit>(
      //     create: (BuildContext context) => sl<ShareCubit>()),
    ];
