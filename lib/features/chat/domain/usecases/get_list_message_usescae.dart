import 'package:dartz/dartz.dart';
import 'package:makanvi_web/features/chat/data/models/get_list_message_model.dart';
import 'package:makanvi_web/features/chat/domain/repositories/chat_repositories.dart';
import '../../../../core/error/failures.dart';
import 'package:makanvi_web/core/usecases/usecases.dart';

class GetListMessageUsecase extends UseCase<GetChatListModel, NoParams> {
  final ChatRepository repository;
  GetListMessageUsecase({
    required this.repository,
  });

  @override
  Future<Either<Failure, GetChatListModel>> call(params) async {
    return await repository.getChatList();
  }
}
