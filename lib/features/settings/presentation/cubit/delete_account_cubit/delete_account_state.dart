part of 'delete_account_cubit.dart';

abstract class DeleteAccountState extends Equatable {
  const DeleteAccountState();

  @override
  List<Object> get props => [];
}

class DeleteAccountInitial extends DeleteAccountState {}

class DeleteAccountLoadingState extends DeleteAccountState {}

class DeleteAccountErrorState extends DeleteAccountState {
  final String message;

  const DeleteAccountErrorState({required this.message});
}

class DeleteAccountSuccessState extends DeleteAccountState {
  final String message;

  const DeleteAccountSuccessState({required this.message});
}
