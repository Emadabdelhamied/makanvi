import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:makanvi_web/core/error/failures.dart';
import 'package:makanvi_web/features/seller_pages/listining_seller/domain/usecases/get_listing_data_usecase.dart';

import '../../../data/models/my_listing_model.dart';

part 'get_one_listing_state.dart';

class GetOneListingCubit extends Cubit<GetOneListingState> {
  GetOneListingCubit({required this.getListingDataUseCase})
      : super(GetOneListingInitial());
  final GetListingDataUseCase getListingDataUseCase;
  Future<void> fGetOneListing(
      {required GetListingDataParams getListingDataParams}) async {
    emit(GetOneListingLoading());
    final response = await getListingDataUseCase(getListingDataParams);

    response.fold(
      (failure) {
        if (failure is ServerFailure) {
          emit(GetOneListingError(message: failure.message));
        }
      },
      (success) {
        log(success.toString());
        emit(GetOneListingSuccess(myListingData: success));
        // emit(OnBoardingInitial());
      },
    );
  }

  SharedPreferences? preferences;

  displayShowcase() async {
    preferences?.remove(
      "showShowcase",
    );
    preferences = await SharedPreferences.getInstance();
    bool? showcaseVisibilityStatus = preferences?.getBool("showShowcase");
    if (showcaseVisibilityStatus == null) {
      preferences?.setBool("showShowcase", false).then((bool success) {
        if (success) {
          log("showcase view");
        } else {
          log("showcase not view");
        }
      });
      return true;
    }
    return false;
  }
}
