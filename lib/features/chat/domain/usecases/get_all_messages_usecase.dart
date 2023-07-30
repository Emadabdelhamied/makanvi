import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../data/models/get_all_messages_model.dart';
import '../repositories/chat_repositories.dart';

class GetAllMessageUsecase extends UseCase<GetAllMessagesModel, MessageParams> {
  final ChatRepository repository;
  GetAllMessageUsecase({
    required this.repository,
  });

  @override
  Future<Either<Failure, GetAllMessagesModel>> call(
      MessageParams params) async {
    return await repository.getAllMessageById(messageParams: params);
  }
}

class MessageParams {
  final int id;
  final int? fromPrpertyId;
  final int currentPage;

  MessageParams({
    required this.id,
    required this.currentPage,
    this.fromPrpertyId,
  });
}
