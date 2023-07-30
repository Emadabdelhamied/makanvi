import 'package:makanvi_web/features/favourite/data/models/favourite_model.dart';

import 'package:makanvi_web/core/error/failures.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/app/app_repository.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/repositories/favourites_repository.dart';
import '../../domain/usecases/add_to_favorite_usecase.dart';
import '../datasources/favourites_datasource.dart';

class FavouriteRepositoryImp extends FavouriteRepository {
  final FavouriteDatasource favouriteDatasource;
  final AppRepository appRepository;
  FavouriteRepositoryImp(
      {required this.favouriteDatasource, required this.appRepository});
  @override
  Future<Either<Failure, FavouritesModel>> favourites() async {
    try {
      final popularLocation = await favouriteDatasource.getFavourites(
        token: appRepository.loadAppData()!.token.toString(),
      );

      return Right(popularLocation);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> addToFavorites(
      {required AddToFavoritesParams params}) async {
    try {
      final data = await favouriteDatasource.addToFavorites(
          token: appRepository.loadAppData()!.token!, params: params);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> removeFromFavorites(
      {required AddToFavoritesParams params}) async {
    try {
      final data = await favouriteDatasource.removeFromFavorites(
          token: appRepository.loadAppData()!.token!, params: params);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> removeAllFavorites() async {
    try {
      final data = await favouriteDatasource.removeAllFavorites(
          token: appRepository.loadAppData()!.token!);
      return Right(data.toString());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
