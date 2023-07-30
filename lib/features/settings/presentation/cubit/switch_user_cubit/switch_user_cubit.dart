import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecases.dart';
import '../../../domain/usecases/switch_user_usecase.dart';

part 'switch_user_state.dart';

class SwitchUserCubit extends Cubit<SwitchUserState> {
  SwitchUserCubit({required this.switchUserUsecase})
      : super(SwitchUserInitial());
  final SwitchUserUsecase switchUserUsecase;
  Future<void> fSwitchUser() async {
    emit(SwitchUserLoadingState());
    final response = await switchUserUsecase(NoParams());
    response.fold(
      (failure) {
        if (failure is ServerFailure) {
          emit(SwitchUserErrorState(message: failure.message));
        }
      },
      (success) {
        emit(SwitchUserSuccessState(message: success));
      },
    );
  }
}
