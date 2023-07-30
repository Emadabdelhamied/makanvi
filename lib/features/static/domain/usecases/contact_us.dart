import 'package:dartz/dartz.dart';
import 'package:makanvi_web/core/usecases/usecases.dart';
import 'package:makanvi_web/features/static/domain/repositories/static_repository.dart';
import '../../../../core/error/failures.dart';

class ContactWithUsUseCase extends UseCase<String, ContactWithUsParams> {
  final StaticRepository staticRepository;

  ContactWithUsUseCase({required this.staticRepository});

  @override
  Future<Either<Failure, String>> call(ContactWithUsParams params) =>
      staticRepository.contactWithUs(params: params);
}

class ContactWithUsParams {
  final String name;
  final String email;
  final String message;

  ContactWithUsParams(
      {required this.name, required this.email, required this.message});
}
