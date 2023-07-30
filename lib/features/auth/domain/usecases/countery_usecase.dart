import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../data/models/countery_model.dart';
import '../repositories/auth_repositories.dart';

class GetCounterySelectUsecase extends UseCase<CounteryModel, NoParams> {
  final AuthRepository repository;
  GetCounterySelectUsecase({
    required this.repository,
  });

  @override
  Future<Either<Failure, CounteryModel>> call(NoParams params,
      {bool isAll = false}) async {
    return await repository.getCounterySelect(isAll: isAll);
  }
}
