import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makanvi_web/core/util/end_points.dart';

import '../../../../bloc/main_cubit/bloc_main_cubit.dart';
// import 'package:pusher_client/pusher_client.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/pusher/pusher.dart';
import '../../../../core/usecases/usecases.dart';
import '../../data/models/get_all_messages_model.dart';
import '../../data/models/get_list_message_model.dart';
import '../../data/models/pusher_success_model.dart';
import '../../domain/usecases/add_message_usecase.dart';
import '../../domain/usecases/fetch_channel_id_usecase.dart';
import '../../domain/usecases/get_all_messages_usecase.dart';
import '../../domain/usecases/get_list_message_usescae.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({
    required this.getListMessageUsecase,
    required this.getAllMessageUsecase,
    required this.addMessageUsecase,
    required this.fetchChannelIdUsecase,
  }) : super(ChatInitial());

  final GetListMessageUsecase getListMessageUsecase;
  final GetAllMessageUsecase getAllMessageUsecase;
  final AddMessageUsecase addMessageUsecase;
  final FetchChannelIdUsecase fetchChannelIdUsecase;
  int currentPage = 1;
  bool isMore = false;
  List<MessageAll> _messagesAll = [];
  List<MessageAll> get getMessages => _messagesAll;
  set setMessages(List<MessageAll> message) {
    _messagesAll.addAll(message);

    log("--------------set ALl Messages done------------------");
    log(_messagesAll.length.toString());
  }

  bool emojiShowing = false;
  set setOneMessages(MessageAll message) {
    _messagesAll.insert(0, message);

    log("--------------set One Message done------------------");
    log(_messagesAll.length.toString());
  }

  removeMessage() {
    _messagesAll.clear();
    log("--------------Clear Message done------------------");
    log(_messagesAll.toString());
  }

  List<Channel> channels = [];
  int len = 0;
  Future<void> fGetListChat({bool isPulled = false}) async {
    channels = [];

    emit(ChatListLoadingState());

    final failOrString = await getListMessageUsecase(NoParams());
    failOrString.fold((fail) {
      if (fail is ServerFailure) {
        print("Error");
        emit(ChatListErrorState(message: fail.message));
      }
    }, (success) {
      log("sucesssssss ");
      channels = success.channels;
      len = channels.length;
      emit(ChatListSuccessLoadingState(getChatListModel: success));
    });
  }

  Future<void> fGetAllMessageChat(
      {bool? ifIsMore,
      bool first = false,
      required int channelId,
      int? propertyId}) async {
    // emit(ChatListAllMessageLoadingState());
    if (state is! ChatListAllMessageLoadingState &&
        state is! ChatListAllMessagePaginationLoadingState) {
      isMore = ifIsMore ?? isMore;
      if (first) {
        currentPage = 1;
        isMore = true;
      }
      if (isMore) {
        if (currentPage == 1) {
          setMessages = [];
          emit(ChatListAllMessageLoadingState());
        } else {
          emit(ChatListAllMessagePaginationLoadingState());
        }
        final failOrString = await getAllMessageUsecase(MessageParams(
            id: channelId,
            currentPage: currentPage,
            fromPrpertyId: propertyId));
        failOrString.fold((fail) {
          if (fail is ServerFailure) {
            emit(ChatListAllMessageErrorState(message: fail.message));
          }
        }, (success) {
          if (currentPage == int.parse(success.prevPage)) {
            currentPage += 1;
          } else {
            isMore = false;
          }
          if (currentPage == 1) {
            setMessages = success.messages;
          } else {
            _messagesAll.clear();
            setMessages = success.messages;
          }
          log(success.messages.length.toString());
          //setMessages = success.messages;
          emit(ChatListAllMessageSuccessLoadingState(
              getAllMessagesModel: getMessages));
        });
      }
    }
  }

  // final TextEditingController messageController = TextEditingController();

  // Future<void> faddMessage({required int channelId}) async {
  //   emit(AddMessageLoadingState());
  //   final failOrString = await addMessageUsecase(AddMessageParams(
  //       channelId: channelId, body: messageController.text, file: "", seen: 1));
  //   failOrString.fold((fail) {
  //     if (fail is ServerFailure) {
  //       print("Error");
  //       emit(AddMessageErrorState(message: fail.message));
  //     }
  //   }, (success) {
  //     log("sucesssssss ");
  //     messageController.clear();
  //     triggerMessage(message: success.message);
  //     emit(AddMessageSuccessLoadingState(addMessageModel: success));
  //   });
  // }

  // PusherClient? pusher;
  // Channel? channel;
  // triggerMessage({MessageAll? message, String? channelID}) {
  //   // log(channel!.toString());
  //   log(message!.toString());
  //   String senMessage = json.encode(message.toJson());

  //   // channel = pusher.subscribe("chat.${message!.channelId}");
  //   try {
  //     PusherClient.client?.channelTriger(
  //         "presence-chat.$channelID", "client-send-message", senMessage);

  //     // .then((value) {
  //     setOneMessages = message;
  //     emit(ChatInitial());
  //     emit(AddMessageToModelState(message: message));
  //     // });
  //   } catch (e) {
  //     // channel!.cancelEventChannelStream();
  //     print("XXX $e");
  //   }
  // }

  int? _countMember;
  int? get getCountMember => _countMember;
  set setCountMember(int value) {
    _countMember = value;
  }

  Future<void> initPusher(
      {required BuildContext context, required int channelID}) async {
    var token = BlocProvider.of<BlocMainCubit>(context, listen: false)
        .repository
        .loadAppData()!
        .token;

    PusherClient().initialize(
      cluster: "mt1",
      channelID: channelID,
      appKey: EndPoints.appKey,
      onEvent: (PusherEvent event) {
        // if (event.data != null) {
        if (event.event == "new_message") {
          final newMessage = MessageAll.fromJson(jsonDecode(event.data!));
          setOneMessages = newMessage;
          emit(ChatInitial());
          emit(AddMessageToModelState(message: newMessage));
        } else if (event.event == "pusher_internal:member_added") {
          setCountMember = 2;
          log(event.data);
        } else if (event.event == "pusher_internal:subscription_succeeded") {
          final countData = ModelSucessPusher.fromJson(jsonDecode(event.data!));
          setCountMember = countData.presence.count;
          log(event.data);
        } else if (event.event == "pusher_internal:member_removed") {
          setCountMember = 1;
          log(event.data);
        }

        // }
      },
      authEndpoint: EndPoints.authPusher,
      authEndpointheaders: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        'Authorization': 'Bearer $token',
      },
    );
    // PusherAuth auth = PusherAuth(
    // for auth endpoint use full url
    // '${EndPoints.baseUrl}/broadcasting/auth',
    // headers: {
    // 'Authorization': 'Bearer $token',
    // "Accept": "application/json",
    // },
    // );
    // pusher = PusherClient(
    // "41611a3e2fc25d630bb4",
    // PusherOptions(
    // cluster: 'eu',
    // encrypted: true,
    // auth: auth,
    // ),
    // enableLogging: true,
    // autoConnect: true,
    // );
    // pusher!.connect();
    // log(pusher!.getSocketId().toString());
    // pusher!.onConnectionError((error) {
    // log("error: $error");
    // });
  }

  // Future<void> initChannelAndEvent({required int chanelId}) async {
  // channel = pusher!.subscribe("presence-chat.$chanelId");
  // log(channel!.name.toString());
  // channel!.bind("client-send-message", (message) {
  // if (message!.data != null) {
  // final newMessage = MessageAll.fromJson(jsonDecode(message.data!));
  // setOneMessages = newMessage;
  // emit(ChatInitial());
  // emit(AddMessageToModelState(message: newMessage));

  // log(newMessage.id.toString());
  // _messagesAll.add(newMessage);
  // notifyListeners();
  // debugPrint(message.data);
  // }
  // });
  // }

  Future<void> fgetChannelId({required int userId}) async {
    emit(GetChannelIdLoadingState());
    final failOrString =
        await fetchChannelIdUsecase(FetchChannelIdParams(id: userId));
    failOrString.fold((fail) {
      if (fail is ServerFailure) {
        print("Error");
        emit(GetChannelIdErrorState(message: fail.message));
      }
    }, (success) {
      log("sucesssssss ");
      emit(GetChannelIdSuccessLoadingState(messageSuccess: success.toString()));
    });
  }
}
