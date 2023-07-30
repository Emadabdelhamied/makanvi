import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../../seller_pages/listining_seller/domain/usecases/create_listings_usecase.dart';
import '../../../data/models/vefiy_otp_model.dart';
import '../../../domain/usecases/verify_otp_usecase.dart';

part 'pincode_state.dart';

class PincodeCubit extends Cubit<PincodeState> {
  PincodeCubit(
      {required this.verifyOtpUsecase, required this.createListingUseCase})
      : super(PincodeInitial());
  final VerifyOtpUsecase verifyOtpUsecase;
  final CreateListingUseCase createListingUseCase;

  String? listingIdValue;
  Future<void> fCreateListings(
      {required CreateListingParms createListingParms}) async {
    emit(AddPropartyLoading());
    final response = await createListingUseCase(createListingParms);

    response.fold(
      (failure) => emit(ErrorAddProparty()),
      (listingId) {
        log(listingId.toString());
        listingIdValue = listingId;
        emit(SucessAddProparty(listingId: listingId));
        // emit(OnBoardingInitial());
      },
    );
  }

  Future<void> fVerfiyOtp({required VerifyOtpParams verifyOtpParams}) async {
    emit(VerfyOtpLoading());
    final response = await verifyOtpUsecase(verifyOtpParams);

    response.fold(
      (failure) {
        if (failure is ServerFailure) {
          emit(VerfyOtpError(errorMessage: failure.message.toString()));
        }
        emit(VerfyOtpError(errorMessage: failure.toString()));
      },
      (success) {
        // AppData appData = AppData(
        //   id: success.user.id.toString(),
        //   displayName: success.user.name,
        //   email: success.user.email,
        //   typeUser: success.user.accountType,
        //   phone: success.user.mobileNumber,
        //   modeUserNow: success.user.accountMode,
        //   languageCode: success.user.lang,
        //   // country: success.user.country['name'],
        //   // city: success.user.city['name'],
        //   photoUrl: success.user.profilePhotoPath ?? "",
        //   // token: success.token,
        //   // title: (success.user.title == "" || success.user.title == null)
        //   //     ? ""
        //   //     : success.user.title['name'] ?? "",
        //   isCompleted: true,
        //   isSeenTutorial: true,
        //   isSelectLang: true,
        //   isGuestUser: false,
        //   isVerfied: true,
        //   // verficationCode: responseDecoded["data"]["verification_code"],
        // );
        log(success.toString());
        emit(VerfyOtpSuccess(verfiyOtpModel: success));
        // emit(OnBoardingInitial());
      },
    );
  }
}
