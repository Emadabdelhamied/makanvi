import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/error/failures.dart';
import '../../../domain/usecases/direct_upgrade_usecase.dart';

part 'direct_upgrade_state.dart';

class DirectUpgradeCubit extends Cubit<DirectUpgradeState> {
  DirectUpgradeCubit({required this.directUpgradeUseCase})
      : super(DirectUpgradeInitial());
  final DirectUpgradeUseCase directUpgradeUseCase;
  Future<void> fDirectUpgrading(
      {required DirectUpgradeParams directUpgradeParams}) async {
    emit(DirectUpgradeLoadingState());
    final response = await directUpgradeUseCase(directUpgradeParams);

    response.fold(
      (failure) {
        if (failure is ServerFailure)
          emit(DirectUpgradeErrorState(message: failure.message));
      },
      (message) {
        log(message);

        emit(DirectUpgradeSuccessState(message: message));
        // emit(OnBoardingInitial());
      },
    );
  }
}
