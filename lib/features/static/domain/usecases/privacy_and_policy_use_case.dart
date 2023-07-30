import 'package:dartz/dartz.dart';
import 'package:makanvi_web/core/usecases/usecases.dart';

import '../../../../core/error/failures.dart';
import '../repositories/static_repository.dart';

class PrivacyAndPolicyUseCase extends UseCase<String, NoParams> {
  final StaticRepository staticRepository;

  PrivacyAndPolicyUseCase({required this.staticRepository});

  @override
  Future<Either<Failure, String>> call(NoParams params) =>
      staticRepository.privacyAndPolicy();
}
