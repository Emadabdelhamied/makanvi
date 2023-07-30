import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:makanvi_web/core/constant/colors/colors.dart';
import 'package:makanvi_web/core/usecases/usecases.dart';
import 'package:makanvi_web/core/widgets/toast.dart';
import 'package:makanvi_web/features/auth/data/models/countery_model.dart';
import 'package:makanvi_web/features/auth/domain/usecases/countery_usecase.dart';

part 'counery_state.dart';

class CouneryCubit extends Cubit<CouneryState> {
  CouneryCubit({
    required this.getCounterySelectUsecase,
  }) : super(CouneryInitial());
  final GetCounterySelectUsecase getCounterySelectUsecase;

  List<CountryAuth> countries = [];
  Future<void> fGetAllCountery() async {
    emit(GetCounteryLoading());
    final response = await getCounterySelectUsecase(NoParams(), isAll: true);

    response.fold(
      (failure) => emit(GetCounteryError()),
      (success) {
        log(success.toString());
        countries = success.countries;
        emit(GetCounterySuccess(counteryModel: success));
        // emit(OnBoardingInitial());
      },
    );
  }

  var mobileCounteryId = 17;
  void setCountryId({required String code, int toast = 0}) {
    var existingIndex = countries.indexWhere((element) {
      log(element.id.toString());
      return element.shortName == code;
    });
    if (existingIndex == -1) {
      toast == 0
          ? customToast(
              backgroundColor: red,
              textColor: white,
              content: 'Selected Country isn\'t exist in our Database',
            )
          : null;
      mobileCounteryId = 17;
    } else {
      log(countries[existingIndex].id.toString());
      mobileCounteryId = countries[existingIndex].id;
    }
  }
}
