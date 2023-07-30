import 'package:dio/dio.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/util/api_basehelper.dart';
import '../../../../core/util/end_points.dart';
import '../../domain/usecases/add_message_usecase.dart';
import '../../domain/usecases/fetch_channel_id_usecase.dart';
import '../../domain/usecases/get_all_messages_usecase.dart';
import '../../domain/usecases/remove_one_list_usecase.dart';
import '../models/add_message_model.dart';
import '../models/get_all_messages_model.dart';
import '../models/get_list_message_model.dart';

abstract class ChatDataSource {
  Future<GetChatListModel> getChatList({required String token});
  Future<GetAllMessagesModel> getAllMessages(
      {required MessageParams messageParams, required String token});
  Future<AddMessageModel> addMessage(
      {required AddMessageParams addMessageParams, required String token});
  Future<int> featchChannelId(
      {required FetchChannelIdParams params, required String token});

  Future<String> removeOneList(
      {required RemoveOneListParams params, required String token});
  Future<String> removeAllList({required String token});
}

class ChatDataSourceImpl extends ChatDataSource {
  ApiBaseHelper apiConsumer;
  ChatDataSourceImpl({required this.apiConsumer});
  @override
  Future<AddMessageModel> addMessage(
      {required AddMessageParams addMessageParams,
      required String token}) async {
    try {
      Map<String, dynamic> body = {
        "channel_id": addMessageParams.channelId,
        "seen": 1,
        "reciever_is_online": addMessageParams.reciverIsOnline
      };
      FormData? formData;
      String fileName = addMessageParams.file.isEmpty
          ? ""
          : addMessageParams.file.split('/').last;
      formData = addMessageParams.file.isEmpty
          ? null
          : FormData.fromMap({
              "file": await MultipartFile.fromFile(
                addMessageParams.file,
                filename: fileName,
              ),
            });
      addMessageParams.body.isNotEmpty
          ? body.addAll({"body": addMessageParams.body})
          : body;
      addMessageParams.file.isNotEmpty
          ? body.addAll({"file": formData!.files.first.value})
          : body;
      final response = await apiConsumer.post(
          url: "${EndPoints.baseUrl}chat/message", token: token, body: body);
      AddMessageModel result = AddMessageModel.fromJson(response);
      if (response == null) {
        throw ServerException(message: 'error');
      } else {
        return result;
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<GetAllMessagesModel> getAllMessages(
      {required MessageParams messageParams, required String token}) async {
    String url =
        "chat/channel/${messageParams.id}/messages?prev_page=${messageParams.currentPage}";
    if (messageParams.fromPrpertyId != null) {
      url = url + "&from_property_id=${messageParams.fromPrpertyId}";
    }
    try {
      final response =
          await apiConsumer.get(url: "${EndPoints.baseUrl}$url", token: token);
      GetAllMessagesModel result = GetAllMessagesModel.fromJson(response);
      if (response == null) {
        throw ServerException(message: 'error');
      } else {
        return result;
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<GetChatListModel> getChatList({required String token}) async {
    try {
      final response = await apiConsumer.get(
          url: "${EndPoints.baseUrl}chat/channels/details", token: token);
      GetChatListModel result = GetChatListModel.fromJson(response);
      if (response == null) {
        throw ServerException(message: 'error');
      } else {
        return result;
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<int> featchChannelId(
      {required FetchChannelIdParams params, required String token}) async {
    try {
      final response = await apiConsumer.post(
          url: "${EndPoints.baseUrl}chat/fetch/channel_id",
          body: {"user_id": params.id},
          token: token);
      int result = response['channel_id'];
      if (response == null) {
        throw ServerException(message: 'error');
      } else {
        return result;
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<String> removeAllList({required String token}) async {
    try {
      final response = await apiConsumer.delete(
          url: "${EndPoints.baseUrl}chat/remove_all_channles", token: token);
      String result = response['message'];
      if (response == null) {
        throw ServerException(message: 'error');
      } else {
        return result;
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<String> removeOneList(
      {required RemoveOneListParams params, required String token}) async {
    try {
      final response = await apiConsumer.delete(
          url: "${EndPoints.baseUrl}chat/remove_channel/${params.channelId}",
          // body: {"user_id": params.userId},
          token: token);
      if (response == null) {
        throw ServerException(message: 'error');
      } else {
        return response["message"];
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }
}
