import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../core/usecases/usecases.dart';
import '../../../data/models/my_listings_all_model.dart';
import '../../../domain/usecases/get_listings_use_case.dart';

part 'get_listing_state.dart';

class GetListingCubit extends Cubit<GetListingState> {
  GetListingCubit({required this.getListingUseCase})
      : super(GetListingInitial());
  final GetListingUseCase getListingUseCase;

  Future<void> fGetAllListings() async {
    emit(GetAllListingLoading());
    final response = await getListingUseCase(NoParams());

    response.fold(
      (failure) => emit(ErrorGetAllListing()),
      (success) {
        log(success.toString());

        emit(SucessGetAllListing(getMyListigsAllModel: success));
        // emit(OnBoardingInitial());
      },
    );
  }
}
