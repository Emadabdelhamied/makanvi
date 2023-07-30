part of 'change_name_rent_or_sell_cubit.dart';

abstract class ChangeNameRentOrSellState extends Equatable {
  const ChangeNameRentOrSellState();

  @override
  List<Object> get props => [];
}

class ChangeNameRentOrSellInitial extends ChangeNameRentOrSellState {}

class NameRentOrSell extends ChangeNameRentOrSellState {
  final String message;

  NameRentOrSell({required this.message});
}
