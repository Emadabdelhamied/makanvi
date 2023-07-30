part of 'agancy_create_cubit.dart';

abstract class AgancyCreateState extends Equatable {
  const AgancyCreateState();

  @override
  List<Object> get props => [];
}

class AgancyCreateInitial extends AgancyCreateState {}

class AgancyCreateLoading extends AgancyCreateState {}

class ErrorAgancyCreate extends AgancyCreateState {
  final String message;

  ErrorAgancyCreate({required this.message});
}

class SucessAgancyCreate extends AgancyCreateState {
  final String message;

  SucessAgancyCreate({required this.message});
}
