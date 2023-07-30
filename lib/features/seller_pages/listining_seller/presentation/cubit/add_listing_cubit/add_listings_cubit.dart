import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/create_listings_usecase.dart';
import '../../../domain/usecases/direct_upgrade_usecase.dart';

part 'add_listings_state.dart';

class AddListingsCubit extends Cubit<AddListingsState> {
  AddListingsCubit(
      {required this.createListingUseCase, required this.directUpgradeUseCase})
      : super(AddListingsInitial());
  final CreateListingUseCase createListingUseCase;
  final DirectUpgradeUseCase directUpgradeUseCase;

  Future<void> fCreateListings(
      {required CreateListingParms createListingParms}) async {
    emit(AddListingLoading());
    final response = await createListingUseCase(createListingParms);

    response.fold(
      (failure) => emit(ErrorAddListing()),
      (listingId) {
        log(listingId.toString());

        emit(SucessAddListing(listingId: listingId));
        // emit(OnBoardingInitial());
      },
    );
  }

  // Future<void> fDirectUpgrading(
  //     {required DirectUpgradeParams directUpgradeParams}) async {
  //   emit(DirectUpgradeLoadingState());
  //   final response = await directUpgradeUseCase(directUpgradeParams);

  //   response.fold(
  //     (failure) {
  //       if (failure is ServerFailure)
  //         emit(DirectUpgradeErrorState(message: failure.message));
  //     },
  //     (message) {
  //       log(message);

  //       emit(DirectUpgradeSuccessState(message: message));
  //       // emit(OnBoardingInitial());
  //     },
  //   );
  // }
}
