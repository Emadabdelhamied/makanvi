import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/favourites_repository.dart';

class AddToFavoritesUsecase extends UseCase<String, AddToFavoritesParams> {
  final FavouriteRepository favouriteRepository;
  AddToFavoritesUsecase({
    required this.favouriteRepository,
  });

  @override
  Future<Either<Failure, String>> call(AddToFavoritesParams params) async {
    return await favouriteRepository.addToFavorites(params: params);
  }
}

class AddToFavoritesParams {
  final int id;
  AddToFavoritesParams({required this.id});
}
