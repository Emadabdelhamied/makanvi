import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecases.dart';
import '../../../domain/usecases/delete_account_usecase.dart';

part 'delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  DeleteAccountCubit({required this.deleteAccountUseCase})
      : super(DeleteAccountInitial());

  final DeleteAccountUseCase deleteAccountUseCase;
  Future<void> fDeleteAccount() async {
    emit(DeleteAccountLoadingState());
    final response = await deleteAccountUseCase(NoParams());

    response.fold(
      (failure) {
        if (failure is ServerFailure) {
          emit(DeleteAccountErrorState(message: failure.message));
        }
      },
      (success) {
        emit(DeleteAccountSuccessState(message: success));
      },
    );
  }
}
