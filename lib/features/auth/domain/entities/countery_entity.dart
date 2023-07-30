import 'package:equatable/equatable.dart';

class CounteryEntity extends Equatable {
  CounteryEntity(
      {required this.id,
      required this.title,
      required this.flag,
      required this.isActive});

  int id;
  int isActive;
  String title;
  String flag;
  // int applicationId;
  @override
  List<Object?> get props => [id, title, flag, isActive];
}
