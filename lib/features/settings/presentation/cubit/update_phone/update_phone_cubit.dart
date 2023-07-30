import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../../auth/data/models/register_model.dart';
import '../../../domain/usecases/update_phone_usecase.dart';
import '../../../domain/usecases/verify_new_phone_usecase.dart';

part 'update_phone_state.dart';

class UpdatePhoneCubit extends Cubit<UpdatePhoneState> {
  UpdatePhoneCubit(
      {required this.updatePhoneNumberUsecase,
      required this.requestPhoneOtpUsecase})
      : super(UpdatePhoneInitial());
  final UpdatePhoneNumberUsecase updatePhoneNumberUsecase;
  final RequestPhoneOtpUsecase requestPhoneOtpUsecase;
  Future<void> fUpdatePhone(
      {required UpdatePhoneNumberParams updatePhoneNumberParams}) async {
    emit(UpdatePhoneLoadingState());
    final response = await updatePhoneNumberUsecase(UpdatePhoneNumberParams(
        phone: updatePhoneNumberParams.phone,
        countryId: updatePhoneNumberParams.countryId,
        otp: updatePhoneNumberParams.otp));
    response.fold(
      (failure) {
        if (failure is ServerFailure) {
          emit(UpdatePhoneErrorState(message: failure.message));
        }
      },
      (success) {
        emit(UpdatePhoneSuccessState(data: success));
      },
    );
  }

  Future<void> fRequestPhoneOtp({required phoneParams params}) async {
    emit(SendOtpPhoneLoading());
    final response = await requestPhoneOtpUsecase(phoneParams(
      phone: params.phone,
      countryId: params.countryId,
    ));
    response.fold(
      (failure) {
        if (failure is ServerFailure) {
          emit(SendOtpPhoneError(message: failure.message));
        }
      },
      (success) {
        emit(SendOtpPhoneSuccess(message: success));
      },
    );
  }
}
