part of 'signup_cubit.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

class SignupInitial extends SignupState {}

class RegisterLodingState extends SignupState {}

class RegisterSuccessState extends SignupState {
  final AppData appData;
  const RegisterSuccessState({required this.appData});
}

class RegisterErrorState extends SignupState {
  final String error;

  const RegisterErrorState({required this.error});
}
