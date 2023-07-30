part of 'popular_location_cubit.dart';

abstract class PopularLocationState extends Equatable {
  const PopularLocationState();

  @override
  List<Object> get props => [];
}

class PopularLocationInitial extends PopularLocationState {}

class GetPopularLocationLoading extends PopularLocationState {}

class GetPopularLocationPaginationLoading extends PopularLocationState {}

class ErrorGetPopularLocation extends PopularLocationState {
  final String message;

  ErrorGetPopularLocation({required this.message});
}

class SucessGetPopularLocation extends PopularLocationState {
  final PopularLocationModel popularLocationModel;

  SucessGetPopularLocation({required this.popularLocationModel});
}
