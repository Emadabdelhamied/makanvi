import 'package:dartz/dartz.dart';
import 'package:makanvi_web/core/usecases/usecases.dart';

import '../../../../core/error/failures.dart';
import '../repositories/auth_repositories.dart';

class LogoutUsecase extends UseCase<String, NoParams> {
  final AuthRepository repository;
  LogoutUsecase({
    required this.repository,
  });

  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return await repository.logout();
  }
}
