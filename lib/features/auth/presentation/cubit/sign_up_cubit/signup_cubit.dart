import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../core/app/app_data.dart';
import '../../../../../core/error/failures.dart';
import '../../../domain/usecases/register_usecase.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit({required this.registerUseCase}) : super(SignupInitial());
  final RegisterUsecas registerUseCase;

  int changeRadioValue = 0;

  // register
  Future<void> fRegister({
    required RegisterParams registerParams,
    required BuildContext context,
    bool isGuest = false,
  }) async {
    emit(RegisterLodingState());
    final response = await registerUseCase(registerParams);
    response.fold(
      (failure) {
        if (failure is ServerFailure) {
          emit(RegisterErrorState(error: failure.message));
        }
      },
      (success) {
        AppData appData = AppData(
          id: success.user.id.toString(),
          displayName: success.user.name,
          email: success.user.email,
          phone: success.user.mobileNumber ?? "",
          photoUrl: success.user.profilePhotoPath ?? "",
          typeUser: success.user.accountType ?? "",
          token: success.token,
          //title: success.user.title == null ? '' : success.user.title['name'],
          isCompleted: (success.user.mobileNumber == null ||
                  success.user.mobileNumber == "")
              ? false
              : true,
          isSeenTutorial: true,
          isSelectLang: true,
          isGuestUser: isGuest == true ? true : false,
          providerType: success.user.provider,
          location: success.user.locationUser == null
              ? ""
              : "${success.user.locationUser!.city},${success.user.locationUser!.country}",
          lat: success.user.locationUser == null
              ? ""
              : success.user.locationUser!.latitude,
          lang: success.user.locationUser == null
              ? ""
              : success.user.locationUser!.longitude,

          // verficationCode: responseDecoded["data"]["verification_code"],
        );
        // log(success.toString());
        emit(RegisterSuccessState(appData: appData));
      },
    );
  }
}
