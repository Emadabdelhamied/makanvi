import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/app/app_data.dart';
import '../../../../../core/error/failures.dart';
import '../../../domain/usecases/login_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.loginUsecas}) : super(LoginInitial());
  final LoginUsecas loginUsecas;

  Future<void> fLogin({
    required LoginParams loginParams,
    bool isGuest = false,
  }) async {
    emit(LoginLoadingState());
    final response = await loginUsecas(loginParams);
    response.fold(
      (failure) {
        if (failure is ServerFailure) {
          emit(LoginErrorState(message: failure.message));
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
          modeUserNow: success.user.accountMode,
          token: success.token,
          //title: success.user.title == null ? '' : success.user.title['name'],
          isCompleted: (success.user.mobileNumber == null ||
                  success.user.mobileNumber == "")
              ? false
              : true,
          providerType: success.user.provider,
          isVerfied: (success.user.mobileNumberVerifiedAt == null ||
                  success.user.mobileNumberVerifiedAt == "")
              ? false
              : true,
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
        emit(LoginSuccessState(
            appData: appData,
            goto: success.subscriptionsAuthModel.listing == null
                ? ""
                : success.subscriptionsAuthModel.listing!.goTo,
            packageId: success.subscriptionsAuthModel.listing == null
                ? ""
                : success.subscriptionsAuthModel.listing!.id.toString()));
      },
    );
  }
}
