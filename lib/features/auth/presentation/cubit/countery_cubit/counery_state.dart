part of 'counery_cubit.dart';

abstract class CouneryState extends Equatable {
  const CouneryState();

  @override
  List<Object> get props => [];
}

class CouneryInitial extends CouneryState {}

class GetCounteryLoading extends CouneryState {}

class GetCounterySuccess extends CouneryState {
  final CounteryModel counteryModel;

  GetCounterySuccess({required this.counteryModel});
}

class GetCounteryError extends CouneryState {}
