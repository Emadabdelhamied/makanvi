import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/auth_repositories.dart';

class UpdateLocationUsecase extends UseCase<String, UpdateLocationParams> {
  final AuthRepository authRepository;

  UpdateLocationUsecase({required this.authRepository});

  @override
  Future<Either<Failure, String>> call(UpdateLocationParams params) =>
      authRepository.updateLocation(updateLocationParams: params);
}

class UpdateLocationParams {
  final String countery;
  final String state;
  final String city;
  final String lat;
  final String lang;

  UpdateLocationParams({
    this.countery = "",
    this.state = "",
    this.city = "",
    this.lang = "",
    this.lat = "",
  });
}
