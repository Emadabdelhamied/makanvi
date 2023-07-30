part of 'direct_upgrade_cubit.dart';

abstract class DirectUpgradeState extends Equatable {
  const DirectUpgradeState();

  @override
  List<Object> get props => [];
}

class DirectUpgradeInitial extends DirectUpgradeState {}

class DirectUpgradeLoadingState extends DirectUpgradeState {}

class DirectUpgradeErrorState extends DirectUpgradeState {
  final String message;

  DirectUpgradeErrorState({required this.message});
}

class DirectUpgradeSuccessState extends DirectUpgradeState {
  final String message;

  DirectUpgradeSuccessState({required this.message});
}
