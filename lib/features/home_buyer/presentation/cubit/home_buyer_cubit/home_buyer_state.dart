part of 'home_buyer_cubit.dart';

abstract class HomeBuyerState extends Equatable {
  const HomeBuyerState();

  @override
  List<Object> get props => [];
}

class HomeBuyerInitial extends HomeBuyerState {}

class changeIndexBuyer extends HomeBuyerState {}

class GetHomeBuyerLoading extends HomeBuyerState {}

class GetHomeBuyerPulledLoading extends HomeBuyerState {}

class ErrorGetHomeBuyer extends HomeBuyerState {}

class SucessGetHomeBuyer extends HomeBuyerState {
  final HomeBuyerModel homeBuyerModel;

  SucessGetHomeBuyer({required this.homeBuyerModel});
}
