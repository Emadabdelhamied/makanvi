part of 'update_location_cubit.dart';

abstract class UpdateLocationState extends Equatable {
  const UpdateLocationState();

  @override
  List<Object> get props => [];
}

class UpdateLocationInitial extends UpdateLocationState {}

class updateLocatinLoading extends UpdateLocationState {}

class updateLocatinError extends UpdateLocationState {
  final String mesage;

  updateLocatinError(this.mesage);
}

class updateLocatinSucess extends UpdateLocationState {
  final String mesage;

  updateLocatinSucess(this.mesage);
}

class SettingAddressBuyerTitle extends UpdateLocationState {}

class SetAddressBuyerTitle extends UpdateLocationState {}

/// Update Location
class UpdateLocationLoading extends UpdateLocationState {}

class ErrorUpdateLocation extends UpdateLocationState {}

class SucessUpdateLocation extends UpdateLocationState {
  final String message;

  SucessUpdateLocation({required this.message});
}
