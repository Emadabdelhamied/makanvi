part of 'send_message_cubit.dart';

abstract class SendMessageState extends Equatable {
  const SendMessageState();

  @override
  List<Object> get props => [];
}

class AddMessageLoadingState extends SendMessageState {}

class SendMessageInitial extends SendMessageState {}

class AddMessageSuccessLoadingState extends SendMessageState {
  final AddMessageModel addMessageModel;

  const AddMessageSuccessLoadingState({required this.addMessageModel});
}

class AddMessageErrorState extends SendMessageState {
  final String message;

  const AddMessageErrorState({required this.message});
}

// class AddMessageToModelState extends SendMessageState {
//   final MessageAll message;

//   const AddMessageToModelState({required this.message});
// }