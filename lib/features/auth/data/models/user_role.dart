import 'dart:convert';

UserRoleModel userRoleModelFromJson(String str) =>
    UserRoleModel.fromJson(json.decode(str));

String userRoleModelToJson(UserRoleModel data) => json.encode(data.toJson());

class UserRoleModel {
  UserRoleModel({
    required this.image,
    required this.role,
  });

  String image;
  String role;

  factory UserRoleModel.fromJson(Map<String, dynamic> json) => UserRoleModel(
        image: json["image"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "role": role,
      };
}
