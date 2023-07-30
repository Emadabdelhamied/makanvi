import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecases.dart';
import '../../data/models/my_listings_all_model.dart';
import '../repositories/listings_repositories.dart';

class GetListingUseCase extends UseCase<GetMyListigsAllModel, NoParams> {
  final ListingsRepository listingsRepository;

  GetListingUseCase({
    required this.listingsRepository,
  });

  @override
  Future<Either<Failure, GetMyListigsAllModel>> call(NoParams noParams) async {
    return await listingsRepository.getAllListings();
  }
}
