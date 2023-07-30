part of 'notification_cubit.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class ErrorNotification extends NotificationState {}

class SucessNotification extends NotificationState {
  final NotificationModel notificationModel;

  SucessNotification({required this.notificationModel});
}

class DeleteNotificationLoading extends NotificationState {}

class ErrorDeleteNotification extends NotificationState {}

class SucessDeleteNotification extends NotificationState {
  final String message;

  SucessDeleteNotification({required this.message});
}
