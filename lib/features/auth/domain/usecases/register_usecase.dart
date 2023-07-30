import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/register_entity.dart';
import '../repositories/auth_repositories.dart';

class RegisterUsecas extends UseCase<RegisterEntity, RegisterParams> {
  final AuthRepository authRepository;

  RegisterUsecas({required this.authRepository});

  @override
  Future<Either<Failure, RegisterEntity>> call(RegisterParams params) =>
      authRepository.register(registerParams: params);
}

class RegisterParams {
  final String? accountType;
  final String? agencyName;
  final String lang;
  final String? countryId;
  final String accountMode;
  final String name;
  final String? email;
  final String? password;
  final String confirmPassword;

  RegisterParams({
    this.accountType,
    this.agencyName,
    this.lang = "en",
    this.countryId,
    this.accountMode = "",
    this.email,
    this.password,
    this.name = "",
    this.confirmPassword = "",
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "password_confirmation": confirmPassword,
      };
}
