import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecases.dart';
import '../../data/models/feature_all_model.dart';
import '../repositories/home_buyer_repositories.dart';

class GetFeatureAllUseCase extends UseCase<FeatureAllModel, PaginationParams> {
  final HomeBuyerRepository homeBuyerRepository;

  GetFeatureAllUseCase({
    required this.homeBuyerRepository,
  });

  @override
  Future<Either<Failure, FeatureAllModel>> call(PaginationParams parms) async {
    return await homeBuyerRepository.getFeaturAll(parms: parms);
  }
}

class PaginationParams {
  final int page;

  PaginationParams({required this.page});
}
