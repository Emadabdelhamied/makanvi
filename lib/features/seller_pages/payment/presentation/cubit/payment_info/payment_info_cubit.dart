import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:makanvi_web/core/error/failures.dart';
import 'package:makanvi_web/core/usecases/usecases.dart';

import '../../../data/models/payment_info.dart';
import '../../../domain/usecase/get_payment_info_usecase.dart';

part 'payment_info_state.dart';

class PaymentInfoCubit extends Cubit<PaymentInfoState> {
  PaymentInfoCubit({required this.getPaymentInfoUseCase})
      : super(PaymentInfoInitial());
  final GetPaymentInfoUseCase getPaymentInfoUseCase;
  Future<void> fGetPaymentInfo() async {
    emit(PaymentInfoLoadingState());
    final response = await getPaymentInfoUseCase(NoParams());

    response.fold(
      (failure) {
        if (failure is ServerFailure) {
          emit(PaymentInfoErrorState(message: failure.message));
        }
      },
      (success) {
        log(success.toString());
        emit(PaymentInfoSuccessState(data: success));
        // emit(OnBoardingInitial());
      },
    );
  }
}
