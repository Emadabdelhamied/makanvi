import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecase/add_payment_intent_usecase.dart';

part 'payment_intent_state.dart';

class PaymentIntentCubit extends Cubit<PaymentIntentState> {
  PaymentIntentCubit({required this.addPaymentIntentUseCase})
      : super(PaymentIntentInitial());

  final AddPaymentIntentUseCase addPaymentIntentUseCase;
  Future<void> fAddCardPayment(
      {required AddIntentPaymentParms addIntentPaymentParms}) async {
    emit(AddPaymentIntentLoading());
    final response = await addPaymentIntentUseCase(addIntentPaymentParms);

    response.fold(
      (failure) => emit(ErrorAddPaymentIntent()),
      (idIntent) {
        log(idIntent.toString());

        emit(SucessAddPaymentIntent(intentId: idIntent));
        // emit(OnBoardingInitial());
      },
    );
  }

  int? cardId;
}
