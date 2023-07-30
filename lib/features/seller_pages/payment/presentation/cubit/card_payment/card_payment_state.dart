part of 'card_payment_cubit.dart';

abstract class CardPaymentState extends Equatable {
  const CardPaymentState();

  @override
  List<Object> get props => [];
}

class CardPaymentInitial extends CardPaymentState {}

class AddCardIntentLoading extends CardPaymentState {}

class ErrorAddCardIntent extends CardPaymentState {}

class SucessAddCardIntent extends CardPaymentState {
  final String intentId;

  SucessAddCardIntent({required this.intentId});
}

class DeleteCardIntentLoading extends CardPaymentState {}

class ErrorDeleteCardIntent extends CardPaymentState {}

class SucessDeleteCardIntent extends CardPaymentState {
  final String message;

  SucessDeleteCardIntent({required this.message});
}
