import 'dart:convert';

import '../../../auth/data/models/register_model.dart';
import '../../domain/entities/update_profile_entity.dart';

UpdateProfileModel updateProfileModelFromJson(String str) =>
    UpdateProfileModel.fromJson(json.decode(str));

class UpdateProfileModel extends UpdateProfileEntity {
  UpdateProfileModel({required super.message, required super.user});

  factory UpdateProfileModel.fromJson(Map<String, dynamic> json) =>
      UpdateProfileModel(
        message: json["message"],
        user: UserModel.fromJson(json["user"]),
      );
}
