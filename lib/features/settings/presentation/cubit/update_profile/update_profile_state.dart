part of 'update_profile_cubit.dart';

abstract class UpdateProfileState extends Equatable {
  const UpdateProfileState();

  @override
  List<Object> get props => [];
}

class UpdateProfileInitial extends UpdateProfileState {}

class UploadImage extends UpdateProfileState {}

class UpdateProfileLoadingState extends UpdateProfileState {}

class UpdateProfileLoadedState extends UpdateProfileState {
  final AppData appData;

  const UpdateProfileLoadedState({required this.appData});
}

class UpdateProfileErrorState extends UpdateProfileState {
  final String message;
  const UpdateProfileErrorState({required this.message});
}
