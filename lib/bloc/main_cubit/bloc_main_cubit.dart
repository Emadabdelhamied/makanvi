import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/app/app_data.dart';
import '../../core/app/app_preferences_storage.dart';

part 'bloc_main_state.dart';

class BlocMainCubit extends Cubit<BlocMainState> {
  BlocMainCubit({
    required this.repository,
  }) : super(BlocMainInitial()) {
    _appData = repository.loadAppData();
  }
  // final AppRepository repository;
  final Preferences repository;
  AppData? _appData;
  AppState get appState {
    if (_appData == null || _appData!.isSeenTutorial != true) {
      return AppState.notSeenTutorial;
    }
    if (_appData!.isGuestUser == null ||
        (_appData!.isGuestUser != null && _appData!.isGuestUser == true)) {
      return AppState.guest;
    }
    if (_appData!.modeUserNow == null ||
        (_appData!.modeUserNow != null && _appData!.modeUserNow!.isEmpty)) {
      return AppState.selectRole;
    }

    if (_appData != null && (_appData!.id == null || _appData!.id!.isEmpty)) {
      return AppState.unauthenticated;
    }
    if (_appData!.isCompleted == false) {
      return AppState.notCompleted;
    }

    if (_appData!.isVerfied == false) {
      return AppState.notVerified;
    }
    // if (_appData!.isLogedOut == true) {
    //   return AppState.loggedOut;
    // }
    return AppState.authenticated;
  }

  void authenticate(
    AppData data,
  ) async {
    _appData = data.copyWith(
        userId: data.id.toString(),
        name: data.displayName,
        phoneCopy: data.phone,
        emailCopy: data.email,
        tokenCopy: data.token,
        isCompleteed: data.isCompleted,
        isverfied: data.isVerfied,
        seenTutorial: data.isSeenTutorial,
        typeUserCopy: data.typeUser,
        modeUserNowCopy: data.modeUserNow,
        title: data.title,
        notificationStatus: data.notificationStatus,
        langCode: data.languageCode);
    await repository.setAppDataHive(_appData!);
    emit(UpdateDataState(appData: _appData!));
  }

  void updateData(
    AppData data,
  ) async {
    _appData = _appData!.copyWith(
      userId: data.id.toString(),
      name: data.displayName,
      tokenCopy: data.token,
      typeUserCopy: data.typeUser,
      phoneCopy: data.phone,
      emailCopy: data.email,
      photo: data.photoUrl,
      isCompleteed: data.isCompleted,
      isGuestUserCopy: data.isGuestUser,
      isverfied: data.isVerfied,
      notificationStatus: data.notificationStatus,
      title: data.title,
      modeUserNowCopy: data.modeUserNow,
      locationCopy: data.location,
      langCopy: data.lang,
      latCopy: data.lat,
      providerTypeCopy: data.providerType,
      // tokenCopy: data.token,
      // typeUserCopy: data.typeUser,
      langCode: data.languageCode,
    );
    await repository.setAppDataHive(_appData!);
    emit(UpdateDataState(appData: _appData!));
    emit(BlocMainInitial());
  }

  void seenIntro() async {
    if (_appData == null) {
      _appData = AppData(isSeenTutorial: true, isGuestUser: false);
    } else {
      _appData = _appData!.copyWith(seenTutorial: true, isGuestUserCopy: false);
    }
    await repository.setAppDataHive(_appData!);
    emit(UpdateDataState(appData: _appData!));
  }

  void verfied() async {
    if (_appData == null) {
      _appData = AppData(
          isSeenTutorial: true,
          isGuestUser: false,
          isCompleted: true,
          isVerfied: true);
    } else {
      _appData = _appData!.copyWith(
          seenTutorial: true,
          isGuestUserCopy: false,
          isCompleteed: true,
          isverfied: true);
    }
    await repository.setAppDataHive(_appData!);
    emit(UpdateDataState(appData: _appData!));
  }

  void setCountryId(String counteryId) async {
    if (_appData == null) {
      _appData = AppData(
          isSeenTutorial: true, isGuestUser: false, countryId: counteryId);
    } else {
      _appData = _appData!.copyWith(
          seenTutorial: true,
          isGuestUserCopy: false,
          countryIdCopy: counteryId);
    }
    await repository.setAppDataHive(_appData!);
    emit(UpdateDataState(appData: _appData!));
    // emit(BlocMainInitial());
  }

  void setModeUser(String modeUser) async {
    if (_appData == null) {
      _appData = AppData(
          isSeenTutorial: true, isGuestUser: false, modeUserNow: modeUser);
    } else {
      _appData = _appData!.copyWith(
          seenTutorial: true,
          isGuestUserCopy: false,
          modeUserNowCopy: modeUser);
    }
    await repository.setAppDataHive(_appData!);
    emit(UpdateDataState(appData: _appData!));
    emit(BlocMainInitial());
  }

  void setTypeUser(String typeUser) async {
    if (_appData == null) {
      _appData =
          AppData(isSeenTutorial: true, isGuestUser: false, typeUser: typeUser);
    } else {
      _appData = _appData!.copyWith(
          seenTutorial: true, isGuestUserCopy: false, typeUserCopy: typeUser);
    }
    await repository.setAppDataHive(_appData!);
    emit(UpdateDataState(appData: _appData!));
    emit(BlocMainInitial());
  }

  void setGuestUser() async {
    if (_appData == null) {
      _appData = AppData(
          isSeenTutorial: true, isGuestUser: true, modeUserNow: "buyer");
    } else {
      _appData = _appData!.copyWith(
          seenTutorial: true, isGuestUserCopy: true, modeUserNowCopy: "buyer");
    }
    await repository.setAppDataHive(_appData!);
    emit(UpdateDataState(appData: _appData!));
    emit(BlocMainInitial());
  }

  void updateLocation(
      {required String location,
      required String lat,
      required String lang}) async {
    if (_appData == null) {
      _appData = AppData(
          isSeenTutorial: true, location: location, lang: lang, lat: lat);
    } else {
      _appData = _appData!.copyWith(
          seenTutorial: true,
          locationCopy: location,
          langCopy: lang,
          latCopy: lat);
    }
    await repository.setAppDataHive(_appData!);
    emit(UpdateDataState(appData: _appData!));
    emit(BlocMainInitial());
  }

  void unAuthenticate() async {
    _appData = _appData!.copyWith(
        seenTutorial: false,
        isGuestUserCopy: false,
        isverfied: false,
        tokenCopy: "",
        userId: "",
        phoneCopy: "",
        name: "",
        photo: "",
        typeUserCopy: "",
        notificationStatus: "",
        title: '',
        langCopy: "",
        latCopy: "",
        locationCopy: "",
        emailCopy: "");

    await repository.setAppDataHive(_appData!);
    emit(UpdateDataState(appData: _appData!));
    emit(BlocMainInitial());
  }

  // PersistentTabController controller = PersistentTabController();
}
