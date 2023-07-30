part of 'get_one_listing_cubit.dart';

abstract class GetOneListingState extends Equatable {
  const GetOneListingState();

  @override
  List<Object> get props => [];
}

class GetOneListingInitial extends GetOneListingState {}

class GetOneListingLoading extends GetOneListingState {}

class GetOneListingSuccess extends GetOneListingState {
  final MyListingModel myListingData;

  const GetOneListingSuccess({required this.myListingData});
}

class GetOneListingError extends GetOneListingState {
  final String message;

  const GetOneListingError({required this.message});
}
