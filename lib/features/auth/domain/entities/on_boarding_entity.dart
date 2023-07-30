import 'package:equatable/equatable.dart';

class OnboardEntity extends Equatable {
  OnboardEntity(
      {required this.id,
      required this.title,
      required this.description,
      required this.image_path});

  int id;
  String title;
  String description;
  String image_path;

  @override
  List<Object?> get props => [id, title, description, image_path];
}
