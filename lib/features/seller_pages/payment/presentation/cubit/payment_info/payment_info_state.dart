part of 'payment_info_cubit.dart';

abstract class PaymentInfoState extends Equatable {
  const PaymentInfoState();

  @override
  List<Object> get props => [];
}

class PaymentInfoInitial extends PaymentInfoState {}

class PaymentInfoLoadingState extends PaymentInfoState {}

class PaymentInfoErrorState extends PaymentInfoState {
  final String message;

  PaymentInfoErrorState({required this.message});
}

class PaymentInfoSuccessState extends PaymentInfoState {
  final PaymentInfoModel data;

  PaymentInfoSuccessState({required this.data});
}
