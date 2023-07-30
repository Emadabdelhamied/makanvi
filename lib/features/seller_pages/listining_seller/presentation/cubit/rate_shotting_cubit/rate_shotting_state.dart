part of 'rate_shotting_cubit.dart';

abstract class RateShottingState extends Equatable {
  const RateShottingState();

  @override
  List<Object> get props => [];
}

class RateShottingInitial extends RateShottingState {}

class RateShotingLoading extends RateShottingState {}

class RateShotingError extends RateShottingState {
  final String message;

  RateShotingError({required this.message});
}

class RateShotingSucess extends RateShottingState {
  final String message;

  RateShotingSucess({required this.message});
}
