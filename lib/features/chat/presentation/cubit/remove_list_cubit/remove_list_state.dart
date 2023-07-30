part of 'remove_list_cubit.dart';

abstract class RemoveListState extends Equatable {
  const RemoveListState();

  @override
  List<Object> get props => [];
}

class RemoveListInitial extends RemoveListState {}

class RemoveListAllLoading extends RemoveListState {}

class RemoveListAllSucess extends RemoveListState {
  final String message;

  RemoveListAllSucess({required this.message});
}

class RemoveListAllError extends RemoveListState {
  final String message;
  RemoveListAllError({required this.message});
}

class RemoveListOneLoading extends RemoveListState {}

class RemoveListOneSucess extends RemoveListState {
  final String message;

  RemoveListOneSucess({required this.message});
}

class RemoveListOneError extends RemoveListState {
  final String message;
  RemoveListOneError({required this.message});
}
