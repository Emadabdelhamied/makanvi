import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../../../core/app/app_repository.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/chat_repositories.dart';
import '../../domain/usecases/add_message_usecase.dart';
import '../../domain/usecases/fetch_channel_id_usecase.dart';
import '../../domain/usecases/get_all_messages_usecase.dart';
import '../../domain/usecases/remove_one_list_usecase.dart';
import '../datasources/chat_datasourse.dart';
import '../models/add_message_model.dart';
import '../models/get_all_messages_model.dart';
import '../models/get_list_message_model.dart';

class ChatRepositoryImp extends ChatRepository {
  final AppRepository appRepository;
  final ChatDataSource chatDataSource;

  ChatRepositoryImp(
      {required this.appRepository, required this.chatDataSource});

  @override
  Future<Either<Failure, GetAllMessagesModel>> getAllMessageById(
      {required MessageParams messageParams}) async {
    try {
      final data = await chatDataSource.getAllMessages(
          messageParams: messageParams,
          token: appRepository.loadAppData()!.token!);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, GetChatListModel>> getChatList() async {
    try {
      log(appRepository.loadAppData()!.token!);
      final data = await chatDataSource.getChatList(
          token: appRepository.loadAppData()!.token!);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, AddMessageModel>> AddMessage(
      {required AddMessageParams messageParams}) async {
    try {
      final data = await chatDataSource.addMessage(
          addMessageParams: messageParams,
          token: appRepository.loadAppData()!.token!);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, int>> fetchChannelId(
      {required FetchChannelIdParams params}) async {
    try {
      final data = await chatDataSource.featchChannelId(
          params: params, token: appRepository.loadAppData()!.token!);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> removeAllList() async {
    try {
      final data = await chatDataSource.removeAllList(
          token: appRepository.loadAppData()!.token!);
      return Right(data.toString());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> removeOneList(
      {required RemoveOneListParams params}) async {
    try {
      final data = await chatDataSource.removeOneList(
          params: params, token: appRepository.loadAppData()!.token!);
      return Right(data.toString());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
