import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:makanvi_web/core/app/app_data.dart';

import '../../../../../core/error/failures.dart';
import '../../../domain/usecases/update_profile_usecase.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit({
    required this.updateProfileUsecase,
  }) : super(UpdateProfileInitial());
  final UpdateProfileUsecase updateProfileUsecase;
  File? _avatar;
  File? get avatar => _avatar;
  set setAvatar(File img) {
    _avatar = img;
    emit(UploadImage());
    emit(UpdateProfileInitial());
  }

  void removeAvatar() {
    _avatar = null;
  }

  Future<void> fUpdateProfile({required ProfileParams params}) async {
    emit(UpdateProfileLoadingState());
    final response = await updateProfileUsecase(params);

    response.fold(
      (failure) {
        if (failure is ServerFailure) {
          log(failure.message);
          emit(UpdateProfileErrorState(message: failure.message));
        }
      },
      (success) {
        AppData appData = AppData(
          id: success.user.id.toString(),
          displayName: success.user.name,
          email: success.user.email,
          phone: success.user.mobileNumber ?? "",
          // country: success.user.country['name'],
          // city: success.user.city['name'],
          photoUrl: success.user.profilePhotoPath ?? "",
          // title: (success.user.title == "" || success.user.title == null)
          //     ? ""
          //     : success.user.title["name"] ?? "",
          // isCompleted: (success.user.mobileNumber == null ||
          //         success.user.mobileNumber == "")
          //     ? false
          //     : true,
          isSeenTutorial: true,
          // typeUser: success.user.providerName ?? "",
          isSelectLang: true,
          isGuestUser: (success.user.mobileNumber == null ||
                  success.user.mobileNumber == "")
              ? true
              : false,
          // isVerfied: (success.user.mobileVerifiedAt == null ||
          //         success.user.mobileVerifiedAt == "")
          //     ? false
          //     : true,
          // notificationStatus: success.user.notificationStatus ?? "",

          // verficationCode: responseDecoded["data"]["verification_code"],
        );

        emit(UpdateProfileLoadedState(appData: appData));
      },
    );
  }
}
