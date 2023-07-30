import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../data/models/on_boarding_model.dart';
import '../repositories/auth_repositories.dart';

class GetOnBoardingDataUsecase extends UseCase<OnBoardingModel, NoParams> {
  final AuthRepository repository;
  GetOnBoardingDataUsecase({
    required this.repository,
  });

  @override
  Future<Either<Failure, OnBoardingModel>> call(NoParams params) async {
    return await repository.getOnBoardingData();
  }
}
