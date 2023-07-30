import 'package:equatable/equatable.dart';
import 'package:makanvi_web/features/auth/data/models/register_model.dart';

import 'register_entity.dart';

class LoginEntity extends Equatable {
  LoginEntity(
      {required this.user,
      required this.token,
      required this.subscriptionsAuthModel});

  User user;
  String token;
  SubscriptionsAuthModel subscriptionsAuthModel;

  @override
  List<Object?> get props => [user, token];
}
