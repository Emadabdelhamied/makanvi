part of 'close_property_cubit.dart';

abstract class ClosePropertyState extends Equatable {
  const ClosePropertyState();

  @override
  List<Object> get props => [];
}

class ClosePropertyInitial extends ClosePropertyState {}

class ClosePropertyLoading extends ClosePropertyState {}

class ClosePropertyError extends ClosePropertyState {
  final String message;

  ClosePropertyError({required this.message});
}

class ClosePropertySuccess extends ClosePropertyState {
  final String message;

  ClosePropertySuccess({required this.message});
}
