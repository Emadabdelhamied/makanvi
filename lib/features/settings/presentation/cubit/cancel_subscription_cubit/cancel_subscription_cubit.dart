import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:makanvi_web/features/settings/domain/usecases/cancel_subscription_usecase.dart';

import '../../../../../core/error/failures.dart';

part 'cancel_subscription_state.dart';

class CancelSubscriptionCubit extends Cubit<CancelSubscriptionState> {
  CancelSubscriptionCubit({required this.cancelSubscriptionRequestUseCase})
      : super(CancelSubscriptionInitial());
  final CancelSubscriptionRequestUseCase cancelSubscriptionRequestUseCase;
  Future<void> fCancelSubscriptionRequest({required int pakageId}) async {
    emit(CancelSubscriptionLoadingState());
    final response = await cancelSubscriptionRequestUseCase(
        CancelSubscriptionParams(pakageId: pakageId));

    response.fold(
      (failure) {
        if (failure is ServerFailure) {
          emit(CancelSubscriptionErrorState(message: failure.message));
        }
      },
      (success) {
        emit(CancelSubscriptionSuccessState(message: success));
      },
    );
  }
}
