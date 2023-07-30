import 'package:dartz/dartz.dart';
import 'package:makanvi_web/core/error/failures.dart';
import 'package:makanvi_web/core/usecases/usecases.dart';
import 'package:makanvi_web/features/auth/domain/entities/register_entity.dart';
import 'package:makanvi_web/features/auth/domain/repositories/auth_repositories.dart';

class CompleteRegisterUsecase
    extends UseCase<RegisterEntity, CompleteRegisterParams> {
  final AuthRepository authRepository;

  CompleteRegisterUsecase({required this.authRepository});

  @override
  Future<Either<Failure, RegisterEntity>> call(CompleteRegisterParams params) =>
      authRepository.completeRegister(completeRegisterParams: params);
}

class CompleteRegisterParams {
  final String accountType;
  final String? agencyName;
  final String lang;
  final String accountMode;
  final String name;

  CompleteRegisterParams({
    this.accountType = "",
    this.agencyName,
    this.lang = "en",
    this.accountMode = "",
    this.name = "",
  });
}
