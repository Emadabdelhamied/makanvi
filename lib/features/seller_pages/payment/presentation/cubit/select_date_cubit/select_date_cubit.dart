import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/error/failures.dart';
import '../../../domain/usecase/select_date_usecase.dart';

part 'select_date_state.dart';

class SelectDateCubit extends Cubit<SelectDateState> {
  SelectDateCubit({required this.selectDateUseCase})
      : super(SelectDateInitial());
  final SelectDateUseCase selectDateUseCase;
  String date = DateFormat('MM/dd/yyyy', "en")
      .format(DateTime(
          DateTime.now().year, DateTime.now().month, (DateTime.now().day + 1)))
      .toString();

  Future<void> fSelectDateShotting(
      {required SelectDateParms selectDateParms}) async {
    emit(SelectDateLoading());
    final response = await selectDateUseCase(selectDateParms);
    log(date);
    response.fold(
      (failure) {
        if (failure is ServerFailure) {
          emit(ErrorSelectDate(message: failure.message));
        }
      },
      (message) {
        log(message.toString());

        emit(SucessSelectDate(message: message));
        // emit(OnBoardingInitial());
      },
    );
  }
}
