import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:makanvi_web/features/seller_pages/listining_seller/domain/usecases/close_property_usecase.dart';

import '../../../../../../core/error/failures.dart';

part 'close_property_state.dart';

class ClosePropertyCubit extends Cubit<ClosePropertyState> {
  ClosePropertyCubit({required this.closePropertyUseCase})
      : super(ClosePropertyInitial());
  final ClosePropertyUseCase closePropertyUseCase;
  Future<void> fCloseProperty({required String listingId}) async {
    emit(ClosePropertyLoading());
    final response =
        await closePropertyUseCase(ClosePropertyParams(listingId: listingId));

    response.fold(
      (failure) {
        if (failure is ServerFailure)
          emit(ClosePropertyError(message: failure.message));
      },
      (message) {
        log(message);
        emit(ClosePropertySuccess(message: message));
        // emit(OnBoardingInitial());
      },
    );
  }
}
