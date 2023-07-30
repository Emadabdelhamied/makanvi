import 'package:dartz/dartz.dart';
import 'package:makanvi_web/core/app/app_repository.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/static_repository.dart';
import '../../domain/usecases/become_partner.dart';
import '../../domain/usecases/contact_us.dart';
import '../datasources/static_datasource.dart';

class StaticRepositoryImp extends StaticRepository {
  final AppRepository appRepository;
  final StaticDatasource staticDatasource;
  StaticRepositoryImp({
    required this.appRepository,
    required this.staticDatasource,
  });
  @override
  Future<Either<Failure, String>> becomePartener(
      {required BecomePartenerParams params}) async {
    try {
      final becomePartner = await staticDatasource.becomePartener(
          params,
          appRepository.loadAppData()!.email!.isEmpty
              ? "email@test.com"
              : appRepository.loadAppData()!.email!);
      return Right(becomePartner);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> contactWithUs(
      {required ContactWithUsParams params}) async {
    try {
      final becomePartner = await staticDatasource.contactWithUs(
        params,
      );
      return Right(becomePartner);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> aboutUs() async {
    try {
      final aboutUs = await staticDatasource.aboutUs();
      return Right(aboutUs);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> privacyAndPolicy() async {
    try {
      final privacyAndPolicy = await staticDatasource.privacyAndPolicy();
      return Right(privacyAndPolicy);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> termsAndConditions() async {
    try {
      final terms = await staticDatasource.termsAndConditions();
      return Right(terms);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
