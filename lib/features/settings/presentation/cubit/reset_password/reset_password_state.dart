part of 'reset_password_cubit.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class SettingsInitial extends SettingsState {}

class RequestOtpLoadingState extends SettingsState {}

class RequestOtpErrorState extends SettingsState {
  final String message;
  const RequestOtpErrorState({required this.message});
}

class RequestOtpSuccessState extends SettingsState {
  final String message;

  const RequestOtpSuccessState({required this.message});
}

class VerifyOtpLoadingState extends SettingsState {}

class VerifyOtpErrorState extends SettingsState {
  final String message;
  const VerifyOtpErrorState({required this.message});
}

class VerifyOtpSuccessState extends SettingsState {
  final String message;
  const VerifyOtpSuccessState({required this.message});
}

class ResetPasswordLoadingState extends SettingsState {}

class ResetPasswordErrorState extends SettingsState {
  final String message;
  const ResetPasswordErrorState({required this.message});
}

class ResetPasswordSuccessState extends SettingsState {
  final String message;
  const ResetPasswordSuccessState({required this.message});
}
