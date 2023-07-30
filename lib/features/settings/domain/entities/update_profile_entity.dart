import 'package:equatable/equatable.dart';

import '../../../auth/domain/entities/register_entity.dart';

class UpdateProfileEntity extends Equatable {
  UpdateProfileEntity({
    required this.message,
    required this.user,
  });

  String message;
  User user;

  @override
  List<Object?> get props => [message, user];
}
