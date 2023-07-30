part of 'payment_intent_cubit.dart';

abstract class PaymentIntentState extends Equatable {
  const PaymentIntentState();

  @override
  List<Object> get props => [];
}

class PaymentIntentInitial extends PaymentIntentState {}

class AddPaymentIntentLoading extends PaymentIntentState {}

class ErrorAddPaymentIntent extends PaymentIntentState {}

class SucessAddPaymentIntent extends PaymentIntentState {
  final String intentId;

  SucessAddPaymentIntent({required this.intentId});
}