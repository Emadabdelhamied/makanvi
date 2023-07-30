part of 'project_details_cubit.dart';

abstract class ProjectDetailsState extends Equatable {
  const ProjectDetailsState();

  @override
  List<Object> get props => [];
}

class ProjectDetailsInitial extends ProjectDetailsState {}

class ProjectLoadingState extends ProjectDetailsState {}

class ProjectErrorState extends ProjectDetailsState {
  final String message;

  ProjectErrorState({required this.message});
}

class ProjectSuccess extends ProjectDetailsState {
  final Project project;

  ProjectSuccess({required this.project});
}
