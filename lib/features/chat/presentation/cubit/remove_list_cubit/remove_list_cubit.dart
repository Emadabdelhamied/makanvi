import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecases.dart';
import '../../../domain/usecases/remove_all_list_usecase.dart';
import '../../../domain/usecases/remove_one_list_usecase.dart';

part 'remove_list_state.dart';

class RemoveListCubit extends Cubit<RemoveListState> {
  RemoveListCubit(
      {required this.removeAllListUsecase, required this.removeOneListUsecase})
      : super(RemoveListInitial());
  final RemoveAllListUsecase removeAllListUsecase;
  final RemoveOneListUsecase removeOneListUsecase;

  Future<void> fRemoveAllList() async {
    emit(RemoveListAllLoading());
    final failOrString = await removeAllListUsecase(NoParams());
    failOrString.fold((fail) {
      if (fail is ServerFailure) {
        print("Error");
        emit(RemoveListAllError(message: fail.message));
      }
    }, (success) {
      log("sucesssssss ");
      emit(RemoveListAllSucess(message: success.toString()));
    });
  }

  Future<void> fRemoveOneList(
      {required RemoveOneListParams removeOneListParams}) async {
    emit(RemoveListOneLoading());
    final failOrString = await removeOneListUsecase(removeOneListParams);
    failOrString.fold((fail) {
      if (fail is ServerFailure) {
        print("Error");
        emit(RemoveListOneError(message: fail.message));
      }
    }, (success) {
      log("sucesssssss ");
      emit(RemoveListOneSucess(message: success.toString()));
    });
  }
}
