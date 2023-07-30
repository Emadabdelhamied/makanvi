import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecases.dart';
import '../../data/models/get_package_model.dart';
import '../repositories/payment_repositories.dart';

class SelectDateUseCase extends UseCase<String, SelectDateParms> {
  final PaymentRepository paymentRepository;

  SelectDateUseCase({
    required this.paymentRepository,
  });

  @override
  Future<Either<Failure, String>> call(SelectDateParms parms) async {
    return await paymentRepository.selectDateShooting(selectDateParms: parms);
  }
}

class SelectDateParms {
  final int id;
  final String date;

  SelectDateParms({required this.id, required this.date});
}
