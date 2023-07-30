import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecases.dart';
import '../repositories/payment_repositories.dart';

class AddPaymentIntentUseCase extends UseCase<String, AddIntentPaymentParms> {
  final PaymentRepository paymentRepository;

  AddPaymentIntentUseCase({
    required this.paymentRepository,
  });

  @override
  Future<Either<Failure, String>> call(AddIntentPaymentParms parms) async {
    return await paymentRepository.addPaymentIntent(
        addIntentPaymentParms: parms);
  }
}

class AddIntentPaymentParms {
  final String? packageId;
  final String? listingId;
  final String? cardId;
  AddIntentPaymentParms({this.packageId, this.listingId, this.cardId});
}
