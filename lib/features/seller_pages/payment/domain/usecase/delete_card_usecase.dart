import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecases.dart';
import '../../data/models/get_package_model.dart';
import '../repositories/payment_repositories.dart';

class DeleteCardUseCase extends UseCase<String, int> {
  final PaymentRepository paymentRepository;

  DeleteCardUseCase({
    required this.paymentRepository,
  });

  @override
  Future<Either<Failure, String>> call(int id) async {
    return await paymentRepository.deleteCard(id: id);
  }
}
