import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import 'package:makanvi_web/core/usecases/usecases.dart';
import '../repositories/chat_repositories.dart';

class RemoveOneListUsecase extends UseCase<String, RemoveOneListParams> {
  final ChatRepository repository;
  RemoveOneListUsecase({
    required this.repository,
  });

  @override
  Future<Either<Failure, String>> call(RemoveOneListParams params) async {
    return await repository.removeOneList(params: params);
  }
}

class RemoveOneListParams {
  final int channelId;

  RemoveOneListParams({required this.channelId});
}
