import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecases.dart';
import '../repositories/listings_repositories.dart';

class ClosePropertyUseCase extends UseCase<String, ClosePropertyParams> {
  final ListingsRepository listingsRepository;

  ClosePropertyUseCase({
    required this.listingsRepository,
  });

  @override
  Future<Either<Failure, String>> call(ClosePropertyParams params) async {
    return await listingsRepository.closeProperty(closePropertyParams: params);
  }
}

class ClosePropertyParams {
  final String listingId;

  ClosePropertyParams({
    required this.listingId,
  });
}
