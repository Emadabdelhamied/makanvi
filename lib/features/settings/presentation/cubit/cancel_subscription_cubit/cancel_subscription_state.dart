part of 'cancel_subscription_cubit.dart';

abstract class CancelSubscriptionState extends Equatable {
  const CancelSubscriptionState();

  @override
  List<Object> get props => [];
}

class CancelSubscriptionInitial extends CancelSubscriptionState {}

class CancelSubscriptionLoadingState extends CancelSubscriptionState {}

class CancelSubscriptionErrorState extends CancelSubscriptionState {
  final String message;

  CancelSubscriptionErrorState({required this.message});
}

class CancelSubscriptionSuccessState extends CancelSubscriptionState {
  final String message;

  CancelSubscriptionSuccessState({required this.message});
}
