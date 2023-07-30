import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/update_profile_entity.dart';
import '../repositories/setting_repository.dart';

class UpdateProfileUsecase extends UseCase<UpdateProfileEntity, ProfileParams> {
  final SettingsRepository settingsRepository;

  UpdateProfileUsecase({required this.settingsRepository});

  @override
  Future<Either<Failure, UpdateProfileEntity>> call(ProfileParams params) =>
      settingsRepository.updateProfile(params: params);
}

class ProfileParams {
  final String? name;
  final File? image;
  final String? agencyName;
  final String? email;

  ProfileParams({this.name, this.image, this.agencyName, this.email});
}
