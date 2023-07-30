part of 'home_cubit.dart';

abstract class HomeSellerState extends Equatable {
  const HomeSellerState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeSellerState {}

class changeIndexSeller extends HomeSellerState {}

class GetHomeSellerLoading extends HomeSellerState {}

class ErrorGetHomeSeller extends HomeSellerState {}

class SucessGetHomeSeller extends HomeSellerState {
  final HomeSellerModel homeSellerModel;

  SucessGetHomeSeller({required this.homeSellerModel});
}
