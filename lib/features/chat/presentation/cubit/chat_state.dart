part of 'chat_cubit.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

// get chat List  state

class ChatListLoadingState extends ChatState {}

class ChatListSuccessLoadingState extends ChatState {
  final GetChatListModel getChatListModel;

  const ChatListSuccessLoadingState({required this.getChatListModel});
}

class ChatListErrorState extends ChatState {
  final String message;

  const ChatListErrorState({required this.message});
}

// get chat All Message state
class ChatListAllMessageLoadingState extends ChatState {}

class ChatListAllMessagePaginationLoadingState extends ChatState {}

class ChatListAllMessageSuccessLoadingState extends ChatState {
  final List<MessageAll> getAllMessagesModel;

  const ChatListAllMessageSuccessLoadingState(
      {required this.getAllMessagesModel});
}

class ChatListAllMessageErrorState extends ChatState {
  final String message;

  const ChatListAllMessageErrorState({required this.message});
}

// get chat All Message state
// class AddMessageLoadingState extends ChatState {}

// class AddMessageSuccessLoadingState extends ChatState {
//   final AddMessageModel addMessageModel;

//   const AddMessageSuccessLoadingState({required this.addMessageModel});
// }

// class AddMessageErrorState extends ChatState {
//   final String message;

//   const AddMessageErrorState({required this.message});
// }

class AddMessageToModelState extends ChatState {
  final MessageAll message;

  const AddMessageToModelState({required this.message});
}

// get channelId
class GetChannelIdLoadingState extends ChatState {}

class GetChannelIdSuccessLoadingState extends ChatState {
  final String messageSuccess;

  const GetChannelIdSuccessLoadingState({required this.messageSuccess});
}

class GetChannelIdErrorState extends ChatState {
  final String message;

  const GetChannelIdErrorState({required this.message});
}
