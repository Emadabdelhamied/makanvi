import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/usecases/usecases.dart';
import '../../../domain/usecase/adding_card_intent_usecase.dart';
import '../../../domain/usecase/delete_card_usecase.dart';

part 'card_payment_state.dart';

class CardPaymentCubit extends Cubit<CardPaymentState> {
  CardPaymentCubit(
      {required this.adddCardIntentUseCase, required this.deleteCardUseCase})
      : super(CardPaymentInitial());
  final AdddCardIntentUseCase adddCardIntentUseCase;
  final DeleteCardUseCase deleteCardUseCase;

  Future<void> fAddCardPayment() async {
    emit(AddCardIntentLoading());
    final response = await adddCardIntentUseCase(NoParams());

    response.fold(
      (failure) => emit(ErrorAddCardIntent()),
      (idIntent) {
        log(idIntent.toString());

        emit(SucessAddCardIntent(intentId: idIntent));
        // emit(OnBoardingInitial());
      },
    );
  }

  Future<void> fDeleteCardPayment({required int id}) async {
    emit(DeleteCardIntentLoading());
    final response = await deleteCardUseCase(id);

    response.fold(
      (failure) => emit(ErrorDeleteCardIntent()),
      (message) {
        log(message.toString());

        emit(SucessDeleteCardIntent(message: message));
        // emit(OnBoardingInitial());
      },
    );
  }
}
