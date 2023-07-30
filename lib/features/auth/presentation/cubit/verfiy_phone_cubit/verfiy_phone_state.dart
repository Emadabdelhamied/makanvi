part of 'verfiy_phone_cubit.dart';

abstract class VerfiyPhoneState extends Equatable {
  const VerfiyPhoneState();

  @override
  List<Object> get props => [];
}

class VerfiyPhoneInitial extends VerfiyPhoneState {}

class SendOtpPhoneLoading extends VerfiyPhoneState {}

class SendOtpPhoneSuccess extends VerfiyPhoneState {
  final SendOtpModel sendOtpModel;

  SendOtpPhoneSuccess({required this.sendOtpModel});
}

class SendOtpPhoneError extends VerfiyPhoneState {
  final String errorMessage;

  SendOtpPhoneError({required this.errorMessage});
}
