part of 'favorite_icon_cubit.dart';

abstract class FavoriteIconState extends Equatable {
  const FavoriteIconState();

  @override
  List<Object> get props => [];
}

class FavoriteIconInitial extends FavoriteIconState {}

class FavoriteIconLoadingState extends FavoriteIconState {}

class FavoriteIconSuccessState extends FavoriteIconState {
  final String message;
  const FavoriteIconSuccessState({required this.message});
}

class FavoriteIconErrorState extends FavoriteIconState {
  final String message;
  const FavoriteIconErrorState({required this.message});
}

class RemoveFavoriteLoadingState extends FavoriteIconState {}

class RemoveFavoriteSuccessState extends FavoriteIconState {
  final String message;
  const RemoveFavoriteSuccessState({required this.message});
}

class RemoveFavoriteErrorState extends FavoriteIconState {
  final String message;
  const RemoveFavoriteErrorState({required this.message});
}
