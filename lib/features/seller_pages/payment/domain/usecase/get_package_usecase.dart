import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecases.dart';
import '../../data/models/get_package_model.dart';
import '../repositories/payment_repositories.dart';

class GetPaymentPackageUseCase
    extends UseCase<GetPackageAndCardModel, GetPackageParms> {
  final PaymentRepository paymentRepository;

  GetPaymentPackageUseCase({
    required this.paymentRepository,
  });

  @override
  Future<Either<Failure, GetPackageAndCardModel>> call(
      GetPackageParms parms) async {
    return await paymentRepository.getPackagePayment(getPackageParms: parms);
  }
}

class GetPackageParms {
  final String? target;
  final String? purpose;
  GetPackageParms({
    this.target,
    this.purpose,
  });
}
