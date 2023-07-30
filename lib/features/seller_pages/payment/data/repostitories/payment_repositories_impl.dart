import 'package:dartz/dartz.dart';
import 'package:makanvi_web/features/seller_pages/payment/data/models/payment_info.dart';

import '../../../../../core/app/app_repository.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../domain/repositories/payment_repositories.dart';
import '../../domain/usecase/add_payment_intent_usecase.dart';
import '../../domain/usecase/get_package_usecase.dart';
import '../../domain/usecase/select_date_usecase.dart';
import '../datasource/payment_datasource.dart';
import '../models/get_package_model.dart';

class PayumentRepositoryImpl implements PaymentRepository {
  final PaymentDatasource paymentDatasource;
  final AppRepository appRepository;
  PayumentRepositoryImpl(this.appRepository, {required this.paymentDatasource});

  @override
  Future<Either<Failure, GetPackageAndCardModel>> getPackagePayment(
      {required GetPackageParms getPackageParms}) async {
    try {
      final paymentPackage = await paymentDatasource.getPackagePayment(
          token: appRepository.loadAppData()!.token.toString(),
          getPackageParms: getPackageParms);

      // await local.listingsDatasource(token: user.body.accessToken.toString());
      return Right(paymentPackage);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> addCardIntent() async {
    try {
      final addCard = await paymentDatasource.addCardIntent(
        token: appRepository.loadAppData()!.token.toString(),
      );

      // await local.listingsDatasource(token: user.body.accessToken.toString());
      return Right(addCard);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> addPaymentIntent(
      {required AddIntentPaymentParms addIntentPaymentParms}) async {
    try {
      final paymentPackage = await paymentDatasource.addPaymentIntent(
          token: appRepository.loadAppData()!.token.toString(),
          addIntentPaymentParms: addIntentPaymentParms);

      // await local.listingsDatasource(token: user.body.accessToken.toString());
      return Right(paymentPackage);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> deleteCard({required int id}) async {
    try {
      final deleteCard = await paymentDatasource.deleteCardIntent(
          token: appRepository.loadAppData()!.token.toString(), id: id);

      // await local.listingsDatasource(token: user.body.accessToken.toString());
      return Right(deleteCard);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> selectDateShooting(
      {required SelectDateParms selectDateParms}) async {
    try {
      final deleteCard = await paymentDatasource.selectDateShotting(
          token: appRepository.loadAppData()!.token.toString(),
          selectDateParms: selectDateParms);

      // await local.listingsDatasource(token: user.body.accessToken.toString());
      return Right(deleteCard);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> agancyCreate() async {
    try {
      final agancyCreate = await paymentDatasource.agancyCreate(
        token: appRepository.loadAppData()!.token.toString(),
      );

      // await local.listingsDatasource(token: user.body.accessToken.toString());
      return Right(agancyCreate);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, PaymentInfoModel>> getPaymentInfo() async {
    try {
      final paymentPackage = await paymentDatasource.getPaymentInfo(
        token: appRepository.loadAppData()!.token.toString(),
      );

      // await local.listingsDatasource(token: user.body.accessToken.toString());
      return Right(paymentPackage);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
