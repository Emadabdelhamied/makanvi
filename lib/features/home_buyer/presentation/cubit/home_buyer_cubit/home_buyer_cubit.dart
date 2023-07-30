import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:makanvi_web/core/usecases/usecases.dart';
import 'package:makanvi_web/features/home_buyer/data/models/home_buer_model.dart';
import 'package:makanvi_web/features/home_buyer/domain/usecase/get_home_buyer_usecase.dart';

part 'home_buyer_state.dart';

class HomeBuyerCubit extends Cubit<HomeBuyerState> {
  HomeBuyerCubit({required this.getHomeBuyerUseCase})
      : super(HomeBuyerInitial());

  final GetHomeBuyerUseCase getHomeBuyerUseCase;
  int _currentIndexBuyerHome = 0;
  int get getcurrentIndexBuyerHome => _currentIndexBuyerHome;
  set setcurrentIndexBuyerHome(val) {
    _currentIndexBuyerHome = val;
    emit(HomeBuyerInitial());
    emit(changeIndexBuyer());
  }

  Future<void> fGetHomeBuyer({bool isPulled = false}) async {
    emit(GetHomeBuyerLoading());

    final response = await getHomeBuyerUseCase(NoParams());

    response.fold(
      (failure) => emit(ErrorGetHomeBuyer()),
      (success) {
        log(success.toString());

        emit(SucessGetHomeBuyer(homeBuyerModel: success));
        // emit(OnBoardingInitial());
      },
    );
  }
}
