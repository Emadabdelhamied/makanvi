import 'package:dartz/dartz.dart';
import 'package:makanvi_web/core/usecases/usecases.dart';
import 'package:makanvi_web/features/static/domain/repositories/static_repository.dart';
import '../../../../core/error/failures.dart';

class BecomePartenerUseCase extends UseCase<String, BecomePartenerParams> {
  final StaticRepository staticRepository;

  BecomePartenerUseCase({required this.staticRepository});

  @override
  Future<Either<Failure, String>> call(BecomePartenerParams params) =>
      staticRepository.becomePartener(params: params);
}

class BecomePartenerParams {
  final String name;
  final String contactEmail;
  final String mobileContryId;
  final String mobileNumber;
  final String message;

  BecomePartenerParams({
    required this.name,
    required this.mobileNumber,
    required this.contactEmail,
    required this.message,
    required this.mobileContryId,
  });
}
