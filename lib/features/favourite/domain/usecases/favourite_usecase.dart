import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecases.dart';
import '../../data/models/favourite_model.dart';
import '../repositories/favourites_repository.dart';

class FavouritesUseCase extends UseCase<FavouritesModel, NoParams> {
  final FavouriteRepository favouriteRepository;

  FavouritesUseCase({
    required this.favouriteRepository,
  });

  @override
  Future<Either<Failure, FavouritesModel>> call(NoParams params) async {
    return await favouriteRepository.favourites();
  }
}
