import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/favourite_model.dart';
import '../usecases/add_to_favorite_usecase.dart';

abstract class FavouriteRepository {
  Future<Either<Failure, FavouritesModel>> favourites();
  Future<Either<Failure, String>> addToFavorites(
      {required AddToFavoritesParams params});
  Future<Either<Failure, String>> removeFromFavorites(
      {required AddToFavoritesParams params});
  Future<Either<Failure, String>> removeAllFavorites();
}
