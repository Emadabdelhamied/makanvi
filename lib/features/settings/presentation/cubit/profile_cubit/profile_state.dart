part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  final ProfileModel user;

  const ProfileLoadedState({required this.user});
}

class ProfileErrorState extends ProfileState {
  final String message;
  const ProfileErrorState({required this.message});
}
