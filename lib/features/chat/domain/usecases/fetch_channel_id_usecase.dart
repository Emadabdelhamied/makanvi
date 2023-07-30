import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import 'package:makanvi_web/core/usecases/usecases.dart';
import '../repositories/chat_repositories.dart';

class FetchChannelIdUsecase extends UseCase<int, FetchChannelIdParams> {
  final ChatRepository repository;
  FetchChannelIdUsecase({
    required this.repository,
  });

  @override
  Future<Either<Failure, int>> call(FetchChannelIdParams params) async {
    return await repository.fetchChannelId(params: params);
  }
}

class FetchChannelIdParams {
  final int id;
  FetchChannelIdParams({required this.id});
}
