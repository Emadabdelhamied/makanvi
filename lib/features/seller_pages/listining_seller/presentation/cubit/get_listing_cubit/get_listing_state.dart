part of 'get_listing_cubit.dart';

abstract class GetListingState extends Equatable {
  const GetListingState();

  @override
  List<Object> get props => [];
}

class GetListingInitial extends GetListingState {}

class GetAllListingLoading extends GetListingState {}

class ErrorGetAllListing extends GetListingState {}

class SucessGetAllListing extends GetListingState {
  final GetMyListigsAllModel getMyListigsAllModel;

  SucessGetAllListing({required this.getMyListigsAllModel});
}
