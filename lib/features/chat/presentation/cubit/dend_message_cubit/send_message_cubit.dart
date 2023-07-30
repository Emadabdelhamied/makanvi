import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failures.dart';
import '../../../data/models/add_message_model.dart';
import '../../../domain/usecases/add_message_usecase.dart';

part 'send_message_state.dart';

class SendMessageCubit extends Cubit<SendMessageState> {
  SendMessageCubit({required this.addMessageUsecase})
      : super(SendMessageInitial());
  final AddMessageUsecase addMessageUsecase;

  final TextEditingController messageController = TextEditingController();

  Future<void> faddMessage(
      {required int channelId,
      required int reciverIsOnline,
      required int seen}) async {
    emit(AddMessageLoadingState());
    final failOrString = await addMessageUsecase(AddMessageParams(
        channelId: channelId,
        body: messageController.text,
        file: "",
        seen: seen,
        reciverIsOnline: reciverIsOnline));
    failOrString.fold((fail) {
      if (fail is ServerFailure) {
        log("Error");
        emit(AddMessageErrorState(message: fail.message));
      }
    }, (success) {
      log("sucesssssss ");
      messageController.clear();

      emit(AddMessageSuccessLoadingState(addMessageModel: success));
    });
  }
}
