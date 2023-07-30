part of 'favourite_cubit.dart';

abstract class FavouriteState extends Equatable {
  const FavouriteState();

  @override
  List<Object> get props => [];
}

class FavouriteInitial extends FavouriteState {}

class FavouriteLoadingState extends FavouriteState {}

class FavouriteErrorState extends FavouriteState {
  final String message;

  const FavouriteErrorState({required this.message});
}

class FavouriteSuccess extends FavouriteState {
  final FavouritesModel success;

  const FavouriteSuccess({required this.success});
}
