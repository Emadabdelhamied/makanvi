import 'package:dartz/dartz.dart';
import 'package:makanvi_web/core/usecases/usecases.dart';
import '../../../../core/error/failures.dart';
import '../repositories/setting_repository.dart';

class DeleteAccountUseCase extends UseCase<String, NoParams> {
  final SettingsRepository settingsRepository;

  DeleteAccountUseCase({required this.settingsRepository});

  @override
  Future<Either<Failure, String>> call(NoParams params) =>
      settingsRepository.deleteAccount();
}
