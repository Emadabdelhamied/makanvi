part of 'select_date_cubit.dart';

abstract class SelectDateState extends Equatable {
  const SelectDateState();

  @override
  List<Object> get props => [];
}

class SelectDateInitial extends SelectDateState {}

class SelectDateLoading extends SelectDateState {}

class ErrorSelectDate extends SelectDateState {
  final String message;

  ErrorSelectDate({required this.message});
}

class SucessSelectDate extends SelectDateState {
  final String message;

  SucessSelectDate({required this.message});
}
