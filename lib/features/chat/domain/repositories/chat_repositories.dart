import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/add_message_model.dart';
import '../../data/models/get_all_messages_model.dart';
import '../../data/models/get_list_message_model.dart';
import '../usecases/add_message_usecase.dart';
import '../usecases/fetch_channel_id_usecase.dart';
import '../usecases/get_all_messages_usecase.dart';
import '../usecases/remove_one_list_usecase.dart';

abstract class ChatRepository {
  Future<Either<Failure, GetChatListModel>> getChatList();
  Future<Either<Failure, GetAllMessagesModel>> getAllMessageById(
      {required MessageParams messageParams});
  Future<Either<Failure, AddMessageModel>> AddMessage(
      {required AddMessageParams messageParams});
  Future<Either<Failure, int>> fetchChannelId(
      {required FetchChannelIdParams params});

  Future<Either<Failure, String>> removeOneList(
      {required RemoveOneListParams params});
  Future<Either<Failure, String>> removeAllList();
}
