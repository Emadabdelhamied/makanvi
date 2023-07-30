part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final AppData appData;

  final String goto;
  final String packageId;
  const LoginSuccessState(
      {required this.appData, required this.goto, required this.packageId});
}

class LoginErrorState extends LoginState {
  final String message;
  const LoginErrorState({required this.message});
}
