import 'package:dartz/dartz.dart';
import 'package:makanvi_web/features/settings/data/models/profile_model.dart';

import '../../../../core/error/failures.dart';
import '../../../auth/data/models/register_model.dart';
import '../entities/update_profile_entity.dart';
import '../usecases/cancel_subscription_usecase.dart';
import '../usecases/notification_status_usecase.dart';
import '../usecases/request_otp_usecase.dart';
import '../usecases/reset_password_usecase.dart';
import '../usecases/update_phone_usecase.dart';
import '../usecases/update_profile_usecase.dart';
import '../usecases/verify_new_phone_usecase.dart';
import '../usecases/verify_otp_usecase.dart';

abstract class SettingsRepository {
  Future<Either<Failure, String>> requestOtp({required OtpParams params});
  Future<Either<Failure, String>> verifyOtp({required VerifyParams params});
  Future<Either<Failure, String>> resetPasswordOtp(
      {required ResetPasswordParams params});
  Future<Either<Failure, String>> notificationStatus(
      {required NotificationStatusParams params});
  Future<Either<Failure, ProfileModel>> getProfile();
  Future<Either<Failure, UpdateProfileEntity>> updateProfile(
      {required ProfileParams params});
  Future<Either<Failure, UserModel>> updatePhone(
      {required UpdatePhoneNumberParams params});
  Future<Either<Failure, String>> deleteAccount();
  Future<Either<Failure, String>> switchUserAccount();
  Future<Either<Failure, String>> requestPhoneOtp(
      {required phoneParams params});
  Future<Either<Failure, String>> cancelSubscriptionRequest(
      {required CancelSubscriptionParams params});
}
