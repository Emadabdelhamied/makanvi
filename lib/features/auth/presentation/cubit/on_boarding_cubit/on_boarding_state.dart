part of 'on_boarding_cubit.dart';

abstract class OnBoardingState extends Equatable {
  const OnBoardingState();

  @override
  List<Object> get props => [];
}

class OnBoardingInitial extends OnBoardingState {}

class setSelectedLanguage extends OnBoardingState {}

class setSelectedRole extends OnBoardingState {}

class setSelectedCountery extends OnBoardingState {}

class OnBoardingLoading extends OnBoardingState {}

class OnBoardingSuccess extends OnBoardingState {
  final OnBoardingModel data;

  OnBoardingSuccess({required this.data});
}

class OnBoardingError extends OnBoardingState {}

class GetCounteryLoading extends OnBoardingState {}

class GetCounterySuccess extends OnBoardingState {
  final CounteryModel counteryModel;

  GetCounterySuccess({required this.counteryModel});
}

class GetCounteryError extends OnBoardingState {}
