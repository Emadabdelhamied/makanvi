import 'dart:convert';

import '../../domain/entities/login_entitie.dart';
import 'register_model.dart';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

class LoginModel extends LoginEntity {
  LoginModel(
      {required super.user,
      required super.token,
      required super.subscriptionsAuthModel});
  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        user: UserModel.fromJson(json["user"]),
        token: json["token"],
        subscriptionsAuthModel:
            SubscriptionsAuthModel.fromJson(json["subscriptions"]),
      );
}
