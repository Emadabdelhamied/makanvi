import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../data/models/send_otp_model.dart';
import '../../../domain/usecases/send_otp_phone_usecase.dart';

part 'verfiy_phone_state.dart';

class VerfiyPhoneCubit extends Cubit<VerfiyPhoneState> {
  VerfiyPhoneCubit({required this.sendOtpPhoneUseCase})
      : super(VerfiyPhoneInitial());
  final SendOtpPhoneUseCase sendOtpPhoneUseCase;

  Future<void> fSendOtpPhone({required SendOtpParams sendOtpParams}) async {
    emit(SendOtpPhoneLoading());
    final response = await sendOtpPhoneUseCase(sendOtpParams);

    response.fold(
      (failure) {
        if (failure is ServerFailure) {
          emit(SendOtpPhoneError(errorMessage: failure.message.toString()));
        }
        emit(SendOtpPhoneError(errorMessage: failure.toString()));
      },
      (success) {
        log(success.toString());
        emit(SendOtpPhoneSuccess(sendOtpModel: success));
        // emit(OnBoardingInitial());
      },
    );
  }
}
