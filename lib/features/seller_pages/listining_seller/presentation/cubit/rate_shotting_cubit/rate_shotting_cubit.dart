import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/error/failures.dart';
import '../../../domain/usecases/rate_shotting_usecase.dart';

part 'rate_shotting_state.dart';

class RateShottingCubit extends Cubit<RateShottingState> {
  RateShottingCubit({required this.ratingShootUseCase})
      : super(RateShottingInitial());
  final RatingShootUseCase ratingShootUseCase;

  Future<void> fRateShoting(
      {required RatingShootParams ratingShootParams}) async {
    emit(RateShotingLoading());
    final response = await ratingShootUseCase(ratingShootParams);

    response.fold(
      (failure) {
        if (failure is ServerFailure) {
          emit(RateShotingError(message: failure.message));
        }
      },
      (success) {
        log(success.toString());
        emit(RateShotingSucess(message: success));
        // emit(OnBoardingInitial());
      },
    );
  }
}
