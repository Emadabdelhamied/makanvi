import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecases.dart';
import '../../data/models/home_buer_model.dart';
import '../repositories/home_buyer_repositories.dart';

class GetHomeBuyerUseCase extends UseCase<HomeBuyerModel, NoParams> {
  final HomeBuyerRepository homeBuyerRepository;

  GetHomeBuyerUseCase({
    required this.homeBuyerRepository,
  });

  @override
  Future<Either<Failure, HomeBuyerModel>> call(NoParams parms) async {
    return await homeBuyerRepository.getHomeBuyer();
  }
}
