import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../../core/app/app_data.dart';
import '../../../../core/constant/colors/colors.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../../../core/widgets/toast.dart';
import '../../../seller_pages/listining_seller/domain/usecases/create_listings_usecase.dart';
import '../../domain/usecases/apple_usecase.dart';
import '../../domain/usecases/google_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/update_location_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
      {required this.googleSignInUsecase,
      required this.appleSignInUsecase,
      required this.logoutUsecase,
      required this.createListingUseCase,
      required this.updateLocationUsecase})
      : super(AuthInitial());
  final GoogleSignInUsecase googleSignInUsecase;
  final AppleSignInUsecase appleSignInUsecase;
  final LogoutUsecase logoutUsecase;
  final CreateListingUseCase createListingUseCase;
  final UpdateLocationUsecase updateLocationUsecase;

  var googleSignIn = GoogleSignIn();
  var auth = FirebaseAuth.instance;

  void signInUsingGoogle({
    required GoogleSignInParams googleSignInParams,
    bool isGuest = false,
  }) async {
    try {
      emit(GoogleSigningIn());
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      // AppData().copyWith(
      //     name: googleUser!.displayName!, photo: googleUser.photoUrl!);
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      await auth.signInWithCredential(credential);
      log(googleSignInAuthentication.accessToken.toString());
      fGoogleSignIn(
          googleSignInParams: GoogleSignInParams(
              token: googleSignInAuthentication.accessToken.toString(),
              lang: googleSignInParams.lang,
              accountMode: googleSignInParams.accountMode,
              codnteryId: googleSignInParams.codnteryId),
          isGuest: isGuest);
      emit(GoogleSignInSucess());
    } catch (error) {
      log(error.toString());
      if (error.toString().contains("Null") == false) {
        customToast(
            backgroundColor: red, textColor: white, content: error.toString());
      }

      emit(GoogleSignInError());
    }
  }

  void signInUsingApple({
    required BuildContext context,
    required GoogleSignInParams googleSignInParams,
    bool isGuest = false,
  }) async {
    try {
      emit(AppleSigningIn());
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      log(credential.email.toString());
      fAppleSignIn(
        appleToken: credential.identityToken!,
        isGuest: isGuest,
        googleSignInParams: GoogleSignInParams(
            token: credential.identityToken!,
            lang: googleSignInParams.lang,
            accountMode: googleSignInParams.accountMode,
            codnteryId: googleSignInParams.codnteryId),
      );
      emit(AppleSignInSucess());
    } catch (error) {
      log(error.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
        ),
      );
      emit(AppleSignInError());
    }
  }

  Future<void> fGoogleSignIn({
    required GoogleSignInParams googleSignInParams,
    required isGuest,
  }) async {
    emit(SendGoogleTokenLoadingState());
    final response = await googleSignInUsecase.call(GoogleSignInParams(
        token: googleSignInParams.token,
        lang: googleSignInParams.lang,
        accountMode: googleSignInParams.accountMode,
        codnteryId: googleSignInParams.codnteryId));

    response.fold(
      (failure) {
        if (failure is ServerFailure) {
          customToast(
            backgroundColor: red,
            textColor: white,
            content: failure.message,
          );
        }
        emit(SendGoogleTokenErrorState());
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
          isVerfied: (success.user.mobileNumberVerifiedAt == null ||
                  success.user.mobileNumberVerifiedAt == "")
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
        emit(SendGoogleTokenSuccessState(
            appData: appData,
            goto: success.subscriptionsAuthModel.listing == null
                ? "pay"
                : success.subscriptionsAuthModel.listing!.goTo,
            packageId: success.subscriptionsAuthModel.listing == null
                ? ""
                : success.subscriptionsAuthModel.listing!.id.toString()));
      },
    );
  }

  Future<void> fAppleSignIn({
    required String appleToken,
    required GoogleSignInParams googleSignInParams,
    required isGuest,
  }) async {
    emit(SendAppleTokenLoadingState());
    final response = await appleSignInUsecase.call(GoogleSignInParams(
        token: appleToken,
        lang: googleSignInParams.lang,
        accountMode: googleSignInParams.accountMode,
        codnteryId: googleSignInParams.codnteryId));

    response.fold(
      (failure) {
        emit(SendAppleTokenErrorState());
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
          isVerfied: (success.user.mobileNumberVerifiedAt == null ||
                  success.user.mobileNumberVerifiedAt == "")
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
        log(success.token.toString());
        emit(SendAppleTokenSuccessState(
            appData: appData,
            goto: success.subscriptionsAuthModel.listing == null
                ? "pay"
                : success.subscriptionsAuthModel.listing!.goTo,
            packageId: success.subscriptionsAuthModel.listing == null
                ? ""
                : success.subscriptionsAuthModel.listing!.id.toString()));
      },
    );
  }

  void signOut({required String faceOrGoogle}) async {
    emit(LogOutLoadingState());
    try {
      await auth.signOut();
      if (faceOrGoogle == "apple") {
      } else if (faceOrGoogle == "") {
      } else {
        await googleSignIn.signOut();
      }
      customToast(
          backgroundColor: Colors.green.shade400,
          textColor: white,
          content: 'logged out successfully');
      emit(LogOutSuccessState());
    } catch (e) {
      customToast(
          backgroundColor: Colors.red.shade300,
          textColor: white,
          content: e.toString());
      emit(LogOutErrorState());
    }
  }

  Future<void> fLogout({required String faceOrGoogle}) async {
    emit(LogOutLoadingState());
    final response = await logoutUsecase.call(NoParams());

    if (faceOrGoogle == "apple") {
    } else if (faceOrGoogle == "" || faceOrGoogle == "Email") {
    } else {
      await auth.signOut();
      await googleSignIn.signOut();
    }
    response.fold(
      (failure) => emit(LogOutErrorState()),
      (success) {
        customToast(
          backgroundColor: Colors.green.shade400,
          textColor: Colors.white,
          content: success,
        );
        emit(LogOutSuccessState());
      },
    );
  }

  /// create listings
  String? listingIdValue;
  Future<void> fCreateListingsAuth(
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
}
