import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecases.dart';
import '../../data/models/get_package_model.dart';
import '../repositories/payment_repositories.dart';

class AdddCardIntentUseCase extends UseCase<String, NoParams> {
  final PaymentRepository paymentRepository;

  AdddCardIntentUseCase({
    required this.paymentRepository,
  });

  @override
  Future<Either<Failure, String>> call(NoParams noParams) async {
    return await paymentRepository.addCardIntent();
  }
}
