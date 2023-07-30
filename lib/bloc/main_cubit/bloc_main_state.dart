part of 'bloc_main_cubit.dart';

abstract class BlocMainState extends Equatable {
  const BlocMainState();

  @override
  List<Object> get props => [];
}

class BlocMainInitial extends BlocMainState {}

class UpdateDataState extends BlocMainState {
  final AppData appData;

  const UpdateDataState({required this.appData});
}
