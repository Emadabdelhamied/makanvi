import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/usecases/usecases.dart';
import '../../../data/models/notification_model.dart';
import '../../../domain/usecase/delete_all_notification_usecase.dart';
import '../../../domain/usecase/get_notification_usecase.dart';

part 'notification_state.dart';

class NotificationSellerCubit extends Cubit<NotificationState> {
  NotificationSellerCubit(
      {required this.getNotificationAllUseCase,
      required this.deleteNotifcationAllUseCase})
      : super(NotificationInitial());
  final GetNotificationAllUseCase getNotificationAllUseCase;
  final DeleteNotifcationAllUseCase deleteNotifcationAllUseCase;

  Future<void> fGetNotifcation() async {
    emit(NotificationLoading());
    final response = await getNotificationAllUseCase(NoParams());

    response.fold(
      (failure) => emit(ErrorNotification()),
      (success) {
        log(success.toString());

        emit(SucessNotification(notificationModel: success));
        // emit(OnBoardingInitial());
      },
    );
  }

  Future<void> fDeleteAllNotifcation() async {
    emit(NotificationLoading());
    final response = await deleteNotifcationAllUseCase(NoParams());

    response.fold(
      (failure) => emit(ErrorNotification()),
      (success) {
        log(success.toString());
        fGetNotifcation();
        emit(SucessDeleteNotification(message: success));
        // emit(OnBoardingInitial());
      },
    );
  }
}
