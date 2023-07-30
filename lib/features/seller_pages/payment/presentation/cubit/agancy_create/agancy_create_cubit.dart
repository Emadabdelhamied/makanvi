import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/error/failures.dart';
import '../../../../../../core/usecases/usecases.dart';
import '../../../domain/usecase/agancy_create_usecase.dart';

part 'agancy_create_state.dart';

class AgancyCreateCubit extends Cubit<AgancyCreateState> {
  AgancyCreateCubit({required this.agancyCreateUseCase})
      : super(AgancyCreateInitial());
  final AgancyCreateUseCase agancyCreateUseCase;

  Future<void> fAgancyCreate() async {
    emit(AgancyCreateLoading());
    final response = await agancyCreateUseCase(NoParams());

    response.fold(
      (failure) {
        if (failure is ServerFailure)
          emit(ErrorAgancyCreate(message: failure.message));
      },
      (message) {
        log(message.toString());

        emit(SucessAgancyCreate(message: message));
        // emit(OnBoardingInitial());
      },
    );
  }
}
