import 'package:dartz/dartz.dart';
import 'package:makanvi_web/core/usecases/usecases.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/add_message_model.dart';
import '../repositories/chat_repositories.dart';

class AddMessageUsecase extends UseCase<AddMessageModel, AddMessageParams> {
  final ChatRepository repository;
  AddMessageUsecase({
    required this.repository,
  });

  @override
  Future<Either<Failure, AddMessageModel>> call(AddMessageParams params) async {
    return await repository.AddMessage(messageParams: params);
  }
}

class AddMessageParams {
  final int channelId;
  final String body;
  final String file;
  final int seen;
  final int reciverIsOnline;

  AddMessageParams({
    required this.channelId,
    required this.body,
    required this.file,
    required this.seen,
    required this.reciverIsOnline,
  });
}
