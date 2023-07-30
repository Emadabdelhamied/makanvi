part of 'feature_all_cubit.dart';

abstract class FeatureAllState extends Equatable {
  const FeatureAllState();

  @override
  List<Object> get props => [];
}

class FeatureAllInitial extends FeatureAllState {}

class GetFeatureAllLoading extends FeatureAllState {}

class GetFeatureAllPaginationLoading extends FeatureAllState {}

class ErrorGetFeatureAll extends FeatureAllState {
  final String message;

  ErrorGetFeatureAll({required this.message});
}

class SucessGetFeatureAll extends FeatureAllState {
  final FeatureAllModel featureAllModel;

  SucessGetFeatureAll({required this.featureAllModel});
}
