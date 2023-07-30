import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:makanvi_web/core/usecases/usecases.dart';
import 'package:makanvi_web/features/seller_pages/home_seller/data/models/home_seller_model.dart';
import 'package:makanvi_web/features/seller_pages/home_seller/domain/usecases/home_seller_use_case.dart';

part 'home_state.dart';

class HomeSellerCubit extends Cubit<HomeSellerState> {
  HomeSellerCubit({required this.homeSellerUseCase}) : super(HomeInitial());

  final HomeSellerUseCase homeSellerUseCase;
  int _currentIndexSellerHome = 0;
  int get getcurrentIndexSellerHome => _currentIndexSellerHome;
  set setcurrentIndexSellerHome(val) {
    _currentIndexSellerHome = val;
    emit(HomeInitial());
    emit(changeIndexSeller());
  }

  Future<void> fGetHomeSeller({bool isPulled = false}) async {
    emit(GetHomeSellerLoading());

    final response = await homeSellerUseCase(NoParams());

    response.fold(
      (failure) => emit(ErrorGetHomeSeller()),
      (success) {
        log(success.toString());

        emit(SucessGetHomeSeller(homeSellerModel: success));
        // emit(OnBoardingInitial());
      },
    );
  }
}
