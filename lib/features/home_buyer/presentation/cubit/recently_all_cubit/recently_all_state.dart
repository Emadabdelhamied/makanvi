part of 'recently_all_cubit.dart';

abstract class RecentlyAllState extends Equatable {
  const RecentlyAllState();

  @override
  List<Object> get props => [];
}

class RecentlyAllInitial extends RecentlyAllState {}

class GetRecentlyAllLoading extends RecentlyAllState {}

class GetRecentlyAllPaginationLoading extends RecentlyAllState {}

class ErrorGetRecentlyAll extends RecentlyAllState {
  final String message;

  ErrorGetRecentlyAll({required this.message});
}

class SucessGetRecentlyAll extends RecentlyAllState {
  final RecentlyAllModel recentlyAllModel;

  SucessGetRecentlyAll({required this.recentlyAllModel});
}
