import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecases.dart';
import '../repositories/listings_repositories.dart';

class RatingShootUseCase extends UseCase<String, RatingShootParams> {
  final ListingsRepository listingsRepository;

  RatingShootUseCase({
    required this.listingsRepository,
  });

  @override
  Future<Either<Failure, String>> call(RatingShootParams params) async {
    return await listingsRepository.ratingShoot(ratingShootParams: params);
  }
}

class RatingShootParams {
  final int rate;
  final int propertyId;
  final String review;

  RatingShootParams(
      {required this.rate, required this.review, required this.propertyId});
}
