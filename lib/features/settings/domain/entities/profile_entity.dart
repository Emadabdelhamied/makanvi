import 'package:equatable/equatable.dart';
import 'package:makanvi_web/features/auth/domain/entities/register_entity.dart';

class ProfileEntity extends Equatable {
  ProfileEntity({
    required this.user,
  });
  User user;
  @override
  List<Object?> get props => [user];
}
