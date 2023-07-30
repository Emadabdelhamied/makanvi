import 'package:dartz/dartz.dart';
import 'package:makanvi_web/features/favourite/domain/repositories/favourites_repository.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import 'add_to_favorite_usecase.dart';

class RemoveFromFavoritesUsecase extends UseCase<String, AddToFavoritesParams> {
  final FavouriteRepository favouriteRepository;
  RemoveFromFavoritesUsecase({
    required this.favouriteRepository,
  });

  @override
  Future<Either<Failure, String>> call(AddToFavoritesParams params) async {
    return await favouriteRepository.removeFromFavorites(params: params);
  }
}
