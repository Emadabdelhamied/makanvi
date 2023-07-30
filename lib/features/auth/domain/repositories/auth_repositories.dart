import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/countery_model.dart';
import '../../data/models/get_data_add_probalty_model.dart';
import '../../data/models/on_boarding_model.dart';
import '../../data/models/send_otp_model.dart';
import '../../data/models/vefiy_otp_model.dart';
import '../entities/login_entitie.dart';
import '../entities/register_entity.dart';
import '../usecases/complete_register_usecase.dart';
import '../usecases/google_usecase.dart';
import '../usecases/login_usecase.dart';
import '../usecases/register_usecase.dart';
import '../usecases/send_otp_phone_usecase.dart';
import '../usecases/update_location_usecase.dart';
import '../usecases/verify_otp_usecase.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginEntity>> login(
      {required LoginParams loginParams});
  Future<Either<Failure, RegisterEntity>> register(
      {required RegisterParams registerParams});
  Future<Either<Failure, RegisterEntity>> completeRegister(
      {required CompleteRegisterParams completeRegisterParams});
  Future<Either<Failure, String>> getotp();

  Future<Either<Failure, VerfiyOtpModel>> verifyOtp(
      {required VerifyOtpParams verifyOtpParams});

  Future<Either<Failure, LoginEntity>> googleSignIn(
      {required GoogleSignInParams googleSignInParams});

  Future<Either<Failure, LoginEntity>> appleSignIn(
      {required GoogleSignInParams googleSignInParams});
  Future<Either<Failure, String>> logout();
  Future<Either<Failure, OnBoardingModel>> getOnBoardingData();
  Future<Either<Failure, CounteryModel>> getCounterySelect(
      {bool isAll = false});
  Future<Either<Failure, GetDataAddPropertyModel>> getDataAddProparty();
  Future<Either<Failure, SendOtpModel>> sendOtpPhone(
      {required SendOtpParams sendOtpParams});
  Future<Either<Failure, String>> updateLocation(
      {required UpdateLocationParams updateLocationParams});
}
