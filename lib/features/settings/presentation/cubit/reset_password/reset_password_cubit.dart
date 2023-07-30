import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:makanvi_web/core/error/failures.dart';
import 'package:makanvi_web/features/settings/domain/usecases/request_otp_usecase.dart';
import 'package:makanvi_web/features/settings/domain/usecases/reset_password_usecase.dart';
import 'package:makanvi_web/features/settings/domain/usecases/verify_otp_usecase.dart';

part 'reset_password_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final RequestOtpUsecase requestOtpUsecase;
  final VerifyPasswordOtpUsecase verifyOtpUsecase;
  final ResetPasswordUsecase resetPasswordUsecase;
  SettingsCubit({
    required this.requestOtpUsecase,
    required this.resetPasswordUsecase,
    required this.verifyOtpUsecase,
  }) : super(SettingsInitial());

  Future<void> fRequestOtp(
      {required String phone, required String code}) async {
    emit(RequestOtpLoadingState());
    final response =
        await requestOtpUsecase(OtpParams(phone: phone, code: code));

    response.fold(
      (failure) {
        if (failure is ServerFailure) {
          log(failure.message);
          emit(RequestOtpErrorState(message: failure.message));
        }
      },
      (success) {
        emit(RequestOtpSuccessState(message: success));
      },
    );
  }

  String? token;
  Future<void> fVerifyOtp(
      {required String phone,
      required String code,
      required String otp}) async {
    emit(VerifyOtpLoadingState());
    final response = await verifyOtpUsecase(VerifyParams(
      email: phone,
      code: code,
      otp: otp,
    ));

    response.fold(
      (failure) {
        if (failure is ServerFailure) {
          emit(VerifyOtpErrorState(message: failure.message));
        }
      },
      (success) {
        token = success;
        emit(const VerifyOtpSuccessState(message: 'success'));
      },
    );
  }

  Future<void> fResetPassword(
      {required String password,
      required String confirmedPassword,
      required String token}) async {
    emit(ResetPasswordLoadingState());
    final response = await resetPasswordUsecase(ResetPasswordParams(
        password: password,
        confirmedPassword: confirmedPassword,
        token: token));

    response.fold(
      (failure) {
        if (failure is ServerFailure) {
          emit(ResetPasswordErrorState(message: failure.message));
        }
      },
      (success) {
        emit(ResetPasswordSuccessState(message: success));
      },
    );
  }
}
