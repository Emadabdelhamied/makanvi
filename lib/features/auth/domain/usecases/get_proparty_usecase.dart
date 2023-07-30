import 'package:dartz/dartz.dart';
import 'package:makanvi_web/features/auth/data/models/get_data_add_probalty_model.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/auth_repositories.dart';

class GetPropartyDataUsecase
    extends UseCase<GetDataAddPropertyModel, NoParams> {
  final AuthRepository repository;
  GetPropartyDataUsecase({
    required this.repository,
  });

  @override
  Future<Either<Failure, GetDataAddPropertyModel>> call(NoParams params) async {
    return await repository.getDataAddProparty();
  }
}
