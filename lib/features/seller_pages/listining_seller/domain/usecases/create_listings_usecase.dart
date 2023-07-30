import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecases.dart';
import '../repositories/listings_repositories.dart';

class CreateListingUseCase extends UseCase<String, CreateListingParms> {
  final ListingsRepository listingsRepository;
  CreateListingUseCase({
    required this.listingsRepository,
  });

  @override
  Future<Either<Failure, String>> call(
    CreateListingParms params,
  ) async {
    return await listingsRepository.createListings(createListingParms: params);
  }
}

class CreateListingParms {
  final Map<String, dynamic>? creatListingsModel;
  final List<int>? amenitiesPars;
  final List<dynamic>? featuresPars;

  CreateListingParms({
    this.creatListingsModel,
    this.amenitiesPars,
    this.featuresPars,
  });
}
