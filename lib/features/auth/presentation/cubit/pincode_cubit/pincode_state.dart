part of 'pincode_cubit.dart';

abstract class PincodeState extends Equatable {
  const PincodeState();

  @override
  List<Object> get props => [];
}

class PincodeInitial extends PincodeState {}

class VerfyOtpLoading extends PincodeState {}

class VerfyOtpSuccess extends PincodeState {
  final VerfiyOtpModel verfiyOtpModel;

  VerfyOtpSuccess({required this.verfiyOtpModel});
}

class VerfyOtpError extends PincodeState {
  final String errorMessage;

  VerfyOtpError({required this.errorMessage});
}

class AddPropartyLoading extends PincodeState {}

class ErrorAddProparty extends PincodeState {}

class SucessAddProparty extends PincodeState {
  final String listingId;

  SucessAddProparty({required this.listingId});
}
