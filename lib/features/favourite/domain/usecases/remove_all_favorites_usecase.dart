import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import 'package:makanvi_web/core/usecases/usecases.dart';

import '../repositories/favourites_repository.dart';

class RemoveAllFavoritesUsecase extends UseCase<String, NoParams> {
  final FavouriteRepository favouriteRepository;
  RemoveAllFavoritesUsecase({
    required this.favouriteRepository,
  });

  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return await favouriteRepository.removeAllFavorites();
  }
}
