part of 'complete_register_cubit.dart';

abstract class CompleteRegisterState extends Equatable {
  const CompleteRegisterState();

  @override
  List<Object> get props => [];
}

class CompleteRegisterInitial extends CompleteRegisterState {}

class CompleteRegisterLodingState extends CompleteRegisterState {}

class CompleteRegisterSuccessState extends CompleteRegisterState {
  final AppData appData;
  const CompleteRegisterSuccessState({required this.appData});
}

class CompleteRegisterErrorState extends CompleteRegisterState {
  final String error;

  const CompleteRegisterErrorState({required this.error});
}
