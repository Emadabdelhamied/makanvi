import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/usecases/usecases.dart';
import '../../../data/models/countery_model.dart';
import '../../../data/models/on_boarding_model.dart';
import '../../../domain/usecases/countery_usecase.dart';
import '../../../domain/usecases/on_boardin_usecase.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit(
      {required this.getOnBoardingDataUsecase,
      required this.getCounterySelectUsecase})
      : super(OnBoardingInitial());

  final GetOnBoardingDataUsecase getOnBoardingDataUsecase;
  final GetCounterySelectUsecase getCounterySelectUsecase;

  int _languageIsSelected = 0;
  int get languageIsSelected => _languageIsSelected;
  set setLanguageIsSelected(int value) {
    _languageIsSelected = value;
    emit(setSelectedLanguage());
    emit(OnBoardingInitial());
  }

  int _roleSelectedIndex = 2;
  int get roleSelectedIndex => _roleSelectedIndex;
  set setRoleSelectedIndex(int value) {
    _roleSelectedIndex = value;
    emit(setSelectedRole());
    emit(OnBoardingInitial());
  }

  int? _selectCountery;
  int? get counterySelectedId => _selectCountery;
  set setCounterySelectedId(int value) {
    _selectCountery = value;
    // emit(setSelectedCountery());
    // emit(OnBoardingInitial());
  }

  List<Onboard> onboardsList = [];
  Future<void> fGetOnBoardingData() async {
    emit(OnBoardingLoading());
    final response = await getOnBoardingDataUsecase(NoParams());

    response.fold(
      (failure) => emit(OnBoardingError()),
      (success) {
        log(success.toString());
        onboardsList = success.onboards;
        emit(OnBoardingSuccess(data: success));
      },
    );
  }

  Future<void> fGetCounterySelect() async {
    emit(GetCounteryLoading());
    final response = await getCounterySelectUsecase(NoParams());

    response.fold(
      (failure) => emit(GetCounteryError()),
      (success) {
        log(success.toString());
        emit(GetCounterySuccess(counteryModel: success));
        // emit(OnBoardingInitial());
      },
    );
  }
}
