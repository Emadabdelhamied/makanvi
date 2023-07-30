import 'package:dartz/dartz.dart';
import 'package:makanvi_web/features/seller_pages/payment/domain/usecase/select_date_usecase.dart';
import '../../data/models/payment_info.dart';
import '../usecase/add_payment_intent_usecase.dart';

import '../../../../../core/error/failures.dart';
import '../../data/models/get_package_model.dart';
import '../usecase/get_package_usecase.dart';

abstract class PaymentRepository {
  Future<Either<Failure, GetPackageAndCardModel>> getPackagePayment(
      {required GetPackageParms getPackageParms});

  Future<Either<Failure, String>> addCardIntent();
  Future<Either<Failure, String>> agancyCreate();
  Future<Either<Failure, String>> selectDateShooting(
      {required SelectDateParms selectDateParms});

  Future<Either<Failure, String>> deleteCard({required int id});
  Future<Either<Failure, String>> addPaymentIntent(
      {required AddIntentPaymentParms addIntentPaymentParms});
  Future<Either<Failure, PaymentInfoModel>> getPaymentInfo();
}
