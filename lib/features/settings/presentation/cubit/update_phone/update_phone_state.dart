part of 'update_phone_cubit.dart';

abstract class UpdatePhoneState extends Equatable {
  const UpdatePhoneState();

  @override
  List<Object> get props => [];
}

class UpdatePhoneInitial extends UpdatePhoneState {}

class UpdatePhoneLoadingState extends UpdatePhoneState {}

class UpdatePhoneSuccessState extends UpdatePhoneState {
  final UserModel data;

  const UpdatePhoneSuccessState({required this.data});
}

class UpdatePhoneErrorState extends UpdatePhoneState {
  final String message;

  const UpdatePhoneErrorState({required this.message});
}

class SendOtpPhoneLoading extends UpdatePhoneState {}

class SendOtpPhoneSuccess extends UpdatePhoneState {
  final String message;

  const SendOtpPhoneSuccess({required this.message});
}

class SendOtpPhoneError extends UpdatePhoneState {
  final String message;

  const SendOtpPhoneError({required this.message});
}
