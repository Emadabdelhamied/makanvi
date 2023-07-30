import 'package:dartz/dartz.dart';
import 'package:makanvi_web/features/settings/domain/usecases/cancel_subscription_usecase.dart';
import 'package:makanvi_web/features/settings/domain/usecases/verify_new_phone_usecase.dart';

import '../../../../core/app/app_repository.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../auth/data/models/register_model.dart';
import '../../domain/entities/update_profile_entity.dart';
import '../../domain/repositories/setting_repository.dart';
import '../../domain/usecases/notification_status_usecase.dart';
import '../../domain/usecases/request_otp_usecase.dart';
import '../../domain/usecases/reset_password_usecase.dart';
import '../../domain/usecases/update_phone_usecase.dart';
import '../../domain/usecases/update_profile_usecase.dart';
import '../../domain/usecases/verify_otp_usecase.dart';
import '../datasources/setting_datasource.dart';
import '../models/profile_model.dart';

class SettingsRepositoryImp extends SettingsRepository {
  final SettingDatasource settingDatasource;
  final AppRepository appRepository;
  SettingsRepositoryImp(
      {required this.appRepository, required this.settingDatasource});
  @override
  Future<Either<Failure, String>> requestOtp(
      {required OtpParams params}) async {
    try {
      final requestOtp = await settingDatasource.requestOtp(params);
      return Right(requestOtp);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> verifyOtp(
      {required VerifyParams params}) async {
    try {
      final verifyOtp = await settingDatasource.verifyOtp(params);
      return Right(verifyOtp);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> resetPasswordOtp(
      {required ResetPasswordParams params}) async {
    try {
      final resetPassword = await settingDatasource.resetPassword(params);
      return Right(resetPassword);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> notificationStatus(
      {required NotificationStatusParams params}) async {
    try {
      final resetPassword = await settingDatasource.notificationStatus(
          params: params, token: appRepository.loadAppData()!.token!);
      return Right(resetPassword);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, ProfileModel>> getProfile() async {
    try {
      final userProfile = await settingDatasource.getProfile(
          token: appRepository.loadAppData()!.token!);
      return Right(userProfile);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, UpdateProfileEntity>> updateProfile(
      {required ProfileParams params}) async {
    try {
      final updatedProfile = await settingDatasource.updateProfile(
          params: params, token: appRepository.loadAppData()!.token!);
      return Right(updatedProfile);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, UserModel>> updatePhone(
      {required UpdatePhoneNumberParams params}) async {
    try {
      final updatedPhone = await settingDatasource.updatePhone(
          params: params, token: appRepository.loadAppData()!.token!);
      return Right(updatedPhone);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> deleteAccount() async {
    try {
      final updatedPhone = await settingDatasource.deleteAcount(
          token: appRepository.loadAppData()!.token!);
      return Right(updatedPhone);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> switchUserAccount() async {
    try {
      final updatedPhone = await settingDatasource.switchUser(
          token: appRepository.loadAppData()!.token!);
      return Right(updatedPhone);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> requestPhoneOtp(
      {required phoneParams params}) async {
    try {
      final updatedPhone = await settingDatasource.requestPhoneOtp(
          params: params, token: appRepository.loadAppData()!.token!);
      return Right(updatedPhone);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> cancelSubscriptionRequest(
      {required CancelSubscriptionParams params}) async {
    try {
      final cancelRequest = await settingDatasource.cancelSubscriptionRequest(
          params: params, token: appRepository.loadAppData()!.token!);
      return Right(cancelRequest);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
