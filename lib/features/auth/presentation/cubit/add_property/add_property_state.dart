part of 'add_property_cubit.dart';

abstract class AddPropertyState extends Equatable {
  const AddPropertyState();

  @override
  List<Object> get props => [];
}

class AddPropertyInitial extends AddPropertyState {}

class SetCurrentStep extends AddPropertyState {}

class SetCurrencyState extends AddPropertyState {}

class SettingAddressTitle extends AddPropertyState {}

class SetAddressTitle extends AddPropertyState {}

class LoadingProparty extends AddPropertyState {}

class ErrorProparty extends AddPropertyState {}

class SucessProparty extends AddPropertyState {
  final GetDataAddPropertyModel getDataAddPropertyModel;

  SucessProparty({required this.getDataAddPropertyModel});
}

class AddPropartyLoading extends AddPropertyState {}

class ErrorAddProparty extends AddPropertyState {}

class SucessAddProparty extends AddPropertyState {
  final String message;

  SucessAddProparty({required this.message});
}
