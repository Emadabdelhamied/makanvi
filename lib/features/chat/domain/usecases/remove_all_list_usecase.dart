import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import 'package:makanvi_web/core/usecases/usecases.dart';
import '../repositories/chat_repositories.dart';

class RemoveAllListUsecase extends UseCase<String, NoParams> {
  final ChatRepository repository;
  RemoveAllListUsecase({
    required this.repository,
  });

  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return await repository.removeAllList();
  }
}
