part of 'static_cubit.dart';

abstract class StaticState extends Equatable {
  const StaticState();

  @override
  List<Object> get props => [];
}

class StaticInitial extends StaticState {}

class StaticPagesLoadingState extends StaticState {}

class StaticPagesSuccessState extends StaticState {
  final String message;

  const StaticPagesSuccessState({required this.message});
}

class StaticPagesErrorState extends StaticState {
  final String message;

  const StaticPagesErrorState({required this.message});
}
