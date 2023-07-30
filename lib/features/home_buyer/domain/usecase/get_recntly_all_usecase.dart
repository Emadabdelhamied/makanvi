import 'package:dartz/dartz.dart';
import 'package:makanvi_web/features/home_buyer/data/models/recently_all_model.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecases.dart';
import '../repositories/home_buyer_repositories.dart';
import 'get_feature_all_usecase.dart';

class GetRecentlyAllUseCase
    extends UseCase<RecentlyAllModel, PaginationParams> {
  final HomeBuyerRepository homeBuyerRepository;

  GetRecentlyAllUseCase({
    required this.homeBuyerRepository,
  });

  @override
  Future<Either<Failure, RecentlyAllModel>> call(PaginationParams parms) async {
    return await homeBuyerRepository.getRecentlyAll(parms: parms);
  }
}
