import 'package:dartz/dartz.dart';
import 'package:makanvi_web/features/home_buyer/data/models/feature_all_model.dart';
import 'package:makanvi_web/features/home_buyer/data/models/popular_location_model.dart';
import 'package:makanvi_web/features/home_buyer/data/models/recently_all_model.dart';

import '../../../../../core/error/failures.dart';
import '../../data/models/home_buer_model.dart';
import '../../data/models/project_model.dart';
import '../../data/models/search_model.dart';
import '../usecase/get_feature_all_usecase.dart';
import '../usecase/get_project_details_usecase.dart';
import '../usecase/search_and_filter_usecase.dart';

abstract class HomeBuyerRepository {
  Future<Either<Failure, HomeBuyerModel>> getHomeBuyer();
  Future<Either<Failure, PopularLocationModel>> getPopularLocation(
      {required PaginationParams parms});
  Future<Either<Failure, FeatureAllModel>> getFeaturAll(
      {required PaginationParams parms});
  Future<Either<Failure, SearchModel>> getSearchandFilter(
      {required SearchAndFilterParams searchAndFilterParams,
      required String page});
  Future<Either<Failure, RecentlyAllModel>> getRecentlyAll(
      {required PaginationParams parms});
  Future<Either<Failure, ProjectModel>> getProjectDetails(
      {required ProjectParams parms});
}
