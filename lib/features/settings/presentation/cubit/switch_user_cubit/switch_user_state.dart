part of 'switch_user_cubit.dart';

abstract class SwitchUserState extends Equatable {
  const SwitchUserState();

  @override
  List<Object> get props => [];
}

class SwitchUserInitial extends SwitchUserState {}

class SwitchUserLoadingState extends SwitchUserState {}

class SwitchUserSuccessState extends SwitchUserState {
  final String message;

  const SwitchUserSuccessState({required this.message});
}

class SwitchUserErrorState extends SwitchUserState {
  final String message;

  const SwitchUserErrorState({required this.message});
}
