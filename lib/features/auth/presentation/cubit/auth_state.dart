part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class GoogleSigningIn extends AuthState {}

class GoogleSignInSucess extends AuthState {}

class GoogleSignInError extends AuthState {}

class GoogleSignOut extends AuthState {}

class GoogleSignOutSucess extends AuthState {}

class GoogleSignOutError extends AuthState {}

class SendGoogleTokenLoadingState extends AuthState {}

class SendGoogleTokenSuccessState extends AuthState {
  final AppData appData;
  final String goto;
  final String packageId;

  const SendGoogleTokenSuccessState(
      {required this.appData, required this.goto, required this.packageId});
}

class SendGoogleTokenErrorState extends AuthState {}

class SendAppleTokenLoadingState extends AuthState {}

class AppleSigningIn extends AuthState {}

class AppleSignInSucess extends AuthState {}

class AppleSignInError extends AuthState {}

class SendAppleTokenSuccessState extends AuthState {
  final AppData appData;

  final String goto;
  final String packageId;
  const SendAppleTokenSuccessState(
      {required this.appData, required this.goto, required this.packageId});
}

class SendAppleTokenErrorState extends AuthState {}

class LogOutLoadingState extends AuthState {}

class LogOutErrorState extends AuthState {}

class LogOutSuccessState extends AuthState {}

/// create listing
class AddPropartyLoading extends AuthState {}

class ErrorAddProparty extends AuthState {}

class SucessAddProparty extends AuthState {
  final String listingId;

  SucessAddProparty({required this.listingId});
}
