part of 'edit_property_cubit.dart';

abstract class EditPropertyState extends Equatable {
  const EditPropertyState();

  @override
  List<Object> get props => [];
}

class EditPropertyInitial extends EditPropertyState {}

class SetCurrencyState extends EditPropertyState {}

class SettingNewAddressTitle extends EditPropertyState {}

class SetNewAddressTitle extends EditPropertyState {}

class SettingLocation extends EditPropertyState {}

class GetEditPropartyLoading extends EditPropertyState {}

class GetEditPropartyError extends EditPropertyState {}

class GetEditPropartySuccess extends EditPropertyState {}

class EditPropartyLoading extends EditPropertyState {}

class EditPropartyError extends EditPropertyState {
  final String message;

  EditPropartyError({required this.message});
}

class EditPropartySuccess extends EditPropertyState {
  final String message;

  EditPropartySuccess({required this.message});
}
