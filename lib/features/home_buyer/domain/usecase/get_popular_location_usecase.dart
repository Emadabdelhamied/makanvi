import 'package:dartz/dartz.dart';
import 'package:makanvi_web/features/home_buyer/data/models/popular_location_model.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecases.dart';
import '../repositories/home_buyer_repositories.dart';
import 'get_feature_all_usecase.dart';

class GetPopularLocationUseCase
    extends UseCase<PopularLocationModel, PaginationParams> {
  final HomeBuyerRepository homeBuyerRepository;

  GetPopularLocationUseCase({
    required this.homeBuyerRepository,
  });

  @override
  Future<Either<Failure, PopularLocationModel>> call(
      PaginationParams parms) async {
    return await homeBuyerRepository.getPopularLocation(parms: parms);
  }
}
