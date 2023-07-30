part of 'add_listings_cubit.dart';

abstract class AddListingsState extends Equatable {
  const AddListingsState();

  @override
  List<Object> get props => [];
}

class AddListingsInitial extends AddListingsState {}

class AddListingLoading extends AddListingsState {}

class ErrorAddListing extends AddListingsState {
  // final String message;
  // ErrorAddListing({required this.message});
}

class SucessAddListing extends AddListingsState {
  final String listingId;

  SucessAddListing({required this.listingId});
}

/// direct Upgrade

// class DirectUpgradeLoadingState extends AddListingsState {}

// class DirectUpgradeErrorState extends AddListingsState {
//   final String message;

//   DirectUpgradeErrorState({required this.message});
// }

// class DirectUpgradeSuccessState extends AddListingsState {
//   final String message;

//   DirectUpgradeSuccessState({required this.message});
// }
