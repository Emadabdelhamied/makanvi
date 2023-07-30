import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecases.dart';
import '../../data/models/payment_info.dart';
import '../repositories/payment_repositories.dart';

class GetPaymentInfoUseCase extends UseCase<PaymentInfoModel, NoParams> {
  final PaymentRepository paymentRepository;

  GetPaymentInfoUseCase({
    required this.paymentRepository,
  });

  @override
  Future<Either<Failure, PaymentInfoModel>> call(NoParams parms) async {
    return await paymentRepository.getPaymentInfo();
  }
}
