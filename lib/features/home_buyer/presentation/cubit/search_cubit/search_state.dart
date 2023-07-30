part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchLoadedState extends SearchState {
  final List<Active> data;

  SearchLoadedState({required this.data});
}

class SearchErrorState extends SearchState {
  final String message;

  SearchErrorState({required this.message});
}

class SearchPaginationState extends SearchState {}

class GetRequiredPropartyLoading extends SearchState {}

class GetRequiredPropartyError extends SearchState {}

class GetRequiredPropartySuccess extends SearchState {}

class ResetFilter extends SearchState {}
