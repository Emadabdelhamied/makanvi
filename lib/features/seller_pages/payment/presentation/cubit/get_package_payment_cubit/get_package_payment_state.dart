part of 'get_package_payment_cubit.dart';

abstract class GetPackagePaymentState extends Equatable {
  const GetPackagePaymentState();

  @override
  List<Object> get props => [];
}

class GetPackagePaymentInitial extends GetPackagePaymentState {}

class GetPaymentLoading extends GetPackagePaymentState {}

class ErrorGetPayment extends GetPackagePaymentState {}

class SucessGetPayment extends GetPackagePaymentState {
  final GetPackageAndCardModel getPackageAndCardModel;

  SucessGetPayment({required this.getPackageAndCardModel});
}
