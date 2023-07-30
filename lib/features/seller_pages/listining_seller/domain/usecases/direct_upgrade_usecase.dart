import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecases.dart';
import '../repositories/listings_repositories.dart';

class DirectUpgradeUseCase extends UseCase<String, DirectUpgradeParams> {
  final ListingsRepository listingsRepository;

  DirectUpgradeUseCase({
    required this.listingsRepository,
  });

  @override
  Future<Either<Failure, String>> call(DirectUpgradeParams params) async {
    return await listingsRepository.directUpgrade(directUpgradeParams: params);
  }
}

class DirectUpgradeParams {
  final String listingId;
  final String packageId;

  DirectUpgradeParams({
    required this.listingId,
    required this.packageId,
  });
}
