import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:makanvi_web/features/auth/domain/usecases/update_location_usecase.dart';

import '../../../../core/app/app_repository.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/login_entitie.dart';
import '../../domain/entities/register_entity.dart';
import '../../domain/repositories/auth_repositories.dart';
import '../../domain/usecases/complete_register_usecase.dart';
import '../../domain/usecases/google_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/usecases/send_otp_phone_usecase.dart';
import '../../domain/usecases/verify_otp_usecase.dart';
import '../datasources/remote_datasource/auth_remotedatasource.dart';
import '../models/countery_model.dart';
import '../models/get_data_add_probalty_model.dart';
import '../models/on_boarding_model.dart';
import '../models/send_otp_model.dart';
import '../models/vefiy_otp_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;
  final AppRepository appRepository;
  AuthRepositoryImpl(this.appRepository, {required this.authRemoteDatasource});

  @override
  Future<Either<Failure, LoginEntity>> login(
      {required LoginParams loginParams}) async {
    try {
      final user = await authRemoteDatasource.login(loginParams);
      // await local.cacheUserAccessToken(token: user.body.accessToken.toString());
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, RegisterEntity>> register(
      {required RegisterParams registerParams}) async {
    try {
      final user = await authRemoteDatasource.rigester(registerParams);
      // await local.cacheUserAccessToken(token: user.body.accessToken.toString());
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, RegisterEntity>> completeRegister(
      {required CompleteRegisterParams completeRegisterParams}) async {
    log(appRepository.loadAppData()!.token!);
    try {
      final response = await authRemoteDatasource.completeRegister(
          completeRegisterParams, appRepository.loadAppData()!.token!);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> getotp() async {
    try {
      final getOtp = await authRemoteDatasource.getOtp(
          token: appRepository.loadAppData()!.token!);
      return Right(getOtp);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, VerfiyOtpModel>> verifyOtp(
      {required VerifyOtpParams verifyOtpParams}) async {
    try {
      final response = await authRemoteDatasource.verifyOtp(
          verifyOtpParams, appRepository.loadAppData()!.token!);

      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, LoginEntity>> googleSignIn(
      {required GoogleSignInParams googleSignInParams}) async {
    try {
      final response =
          await authRemoteDatasource.googleSignIn(googleSignInParams);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, LoginEntity>> appleSignIn(
      {required GoogleSignInParams googleSignInParams}) async {
    try {
      final response =
          await authRemoteDatasource.appleSignIn(googleSignInParams);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> logout() async {
    try {
      final logout = await authRemoteDatasource.logout(
          token: appRepository.loadAppData()!.token!);
      return Right(logout);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, OnBoardingModel>> getOnBoardingData() async {
    try {
      final data = await authRemoteDatasource.getOnBoardingData();
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, CounteryModel>> getCounterySelect(
      {bool? isAll}) async {
    try {
      final data = await authRemoteDatasource.getCounterySelect(isAll: isAll!);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, GetDataAddPropertyModel>> getDataAddProparty() async {
    try {
      final data = await authRemoteDatasource.getDataAddProparty();
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, SendOtpModel>> sendOtpPhone(
      {required SendOtpParams sendOtpParams}) async {
    try {
      final data = await authRemoteDatasource.sendOtpPhone(
          sendOtpParams: sendOtpParams,
          token: appRepository.loadAppData()!.token!);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> updateLocation(
      {required UpdateLocationParams updateLocationParams}) async {
    try {
      final data = await authRemoteDatasource.updateLocation(
          updateLocationParams: updateLocationParams,
          token: appRepository.loadAppData()!.token!);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
