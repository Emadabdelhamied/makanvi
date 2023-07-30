import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../usecases/become_partner.dart';
import '../usecases/contact_us.dart';

abstract class StaticRepository {
  Future<Either<Failure, String>> becomePartener(
      {required BecomePartenerParams params});
  Future<Either<Failure, String>> contactWithUs(
      {required ContactWithUsParams params});
  Future<Either<Failure, String>> aboutUs();
  Future<Either<Failure, String>> termsAndConditions();
  Future<Either<Failure, String>> privacyAndPolicy();
}
