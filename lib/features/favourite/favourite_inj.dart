import 'package:get_it/get_it.dart';
import 'package:makanvi_web/features/favourite/data/datasources/favourites_datasource.dart';
import 'package:makanvi_web/features/favourite/domain/repositories/favourites_repository.dart';
import 'package:makanvi_web/features/favourite/domain/usecases/favourite_usecase.dart';
import 'package:makanvi_web/features/favourite/presentation/cubit/favorite_icon/favorite_icon_cubit.dart';
import 'package:makanvi_web/features/favourite/presentation/cubit/favourite_cubit.dart';

import 'data/repositories/favourite_repository_imp.dart';
import 'domain/usecases/add_to_favorite_usecase.dart';
import 'domain/usecases/remove_all_favorites_usecase.dart';
import 'domain/usecases/remove_from_usecase.dart';

Future<void> initFavouriteInjection(GetIt sl) async {
  //* cubit

  sl.registerFactory(() => FavouriteCubit(
        favouritesUseCase: sl(),
      ));
  sl.registerFactory(() => FavoriteIconCubit(
        addToFavoritesUsecase: sl(),
        removeFromFavoritesUsecase: sl(),
        removeAllFavoritesUsecase: sl(),
      ));

  //* Use cases
  sl.registerLazySingleton(
    () => FavouritesUseCase(favouriteRepository: sl()),
  );
  sl.registerLazySingleton(
    () => AddToFavoritesUsecase(favouriteRepository: sl()),
  );
  sl.registerLazySingleton(
    () => RemoveAllFavoritesUsecase(favouriteRepository: sl()),
  );
  sl.registerLazySingleton(
    () => RemoveFromFavoritesUsecase(favouriteRepository: sl()),
  );

  //* Repository
  sl.registerLazySingleton<FavouriteRepository>(
    () => FavouriteRepositoryImp(
      appRepository: sl(),
      favouriteDatasource: sl(),
    ),
  );

  //* Data sources
  sl.registerLazySingleton<FavouriteDatasource>(
    () => FavouriteDatasourceImp(
      apiConsumer: sl(),
    ),
  );
}
