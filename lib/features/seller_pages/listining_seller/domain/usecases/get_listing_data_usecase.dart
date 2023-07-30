import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecases.dart';
import '../../data/models/my_listing_model.dart';
import '../repositories/listings_repositories.dart';

class GetListingDataUseCase
    extends UseCase<MyListingModel, GetListingDataParams> {
  final ListingsRepository listingsRepository;

  GetListingDataUseCase({
    required this.listingsRepository,
  });

  @override
  Future<Either<Failure, MyListingModel>> call(
      GetListingDataParams params) async {
    return await listingsRepository.getListingById(
        getListingDataParams: params);
  }
}

class GetListingDataParams {
  final String listingId;

  GetListingDataParams({
    required this.listingId,
  });
}
