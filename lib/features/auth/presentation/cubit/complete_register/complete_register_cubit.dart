import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/app/app_data.dart';
import '../../../../../core/error/failures.dart';
import '../../../domain/usecases/complete_register_usecase.dart';

part 'complete_register_state.dart';

class CompleteRegisterCubit extends Cubit<CompleteRegisterState> {
  CompleteRegisterCubit({required this.completeRegisterUsecase})
      : super(CompleteRegisterInitial());
  final CompleteRegisterUsecase completeRegisterUsecase;

  Future<void> fCompleteRegister({
    required CompleteRegisterParams completeRegisterParams,
    bool isGuest = false,
  }) async {
    emit(CompleteRegisterLodingState());
    final response = await completeRegisterUsecase(completeRegisterParams);
    response.fold(
      (failure) {
        if (failure is ServerFailure) {
          emit(CompleteRegisterErrorState(error: failure.message));
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
          providerType: success.user.provider,
          isSeenTutorial: true,
          isSelectLang: true,
          isGuestUser: isGuest == true ? true : false,
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
        emit(CompleteRegisterSuccessState(appData: appData));
      },
    );
  }
}
