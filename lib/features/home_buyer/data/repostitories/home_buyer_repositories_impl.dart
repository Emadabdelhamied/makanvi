import 'package:dartz/dartz.dart';
import 'package:makanvi_web/features/home_buyer/data/models/project_model.dart';
import 'package:makanvi_web/features/home_buyer/data/models/recently_all_model.dart';
import 'package:makanvi_web/features/home_buyer/data/models/popular_location_model.dart';
import 'package:makanvi_web/features/home_buyer/data/models/feature_all_model.dart';
import 'package:makanvi_web/features/home_buyer/domain/usecase/get_project_details_usecase.dart';
import 'package:makanvi_web/features/home_buyer/domain/usecase/search_and_filter_usecase.dart';
import 'package:makanvi_web/features/home_buyer/data/models/search_model.dart';

import '../../../../../core/app/app_repository.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../domain/repositories/home_buyer_repositories.dart';
import '../../domain/usecase/get_feature_all_usecase.dart';
import '../datasource/home_buyer_datasource.dart';
import '../models/home_buer_model.dart';

class HomeBuyerRepositoryImpl implements HomeBuyerRepository {
  final HomeBuyerDatasource homeBuyerDatasource;
  final AppRepository appRepository;
  HomeBuyerRepositoryImpl(this.appRepository,
      {required this.homeBuyerDatasource});

  @override
  Future<Either<Failure, HomeBuyerModel>> getHomeBuyer() async {
    try {
      final homeBuyer = await homeBuyerDatasource.getHomeBuyer(
        token: appRepository.loadAppData()!.token.toString(),
      );

      // await local.listingsDatasource(token: user.body.accessToken.toString());
      return Right(homeBuyer);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, FeatureAllModel>> getFeaturAll(
      {required PaginationParams parms}) async {
    try {
      final featureAll = await homeBuyerDatasource.getFeatureAll(
        token: appRepository.loadAppData()!.token.toString(),
        parms: parms,
      );

      // await local.listingsDatasource(token: user.body.accessToken.toString());
      return Right(featureAll);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, PopularLocationModel>> getPopularLocation(
      {required PaginationParams parms}) async {
    try {
      final popularLocation = await homeBuyerDatasource.getPopularLocation(
        token: appRepository.loadAppData()!.token.toString(),
        parms: parms,
      );

      // await local.listingsDatasource(token: user.body.accessToken.toString());
      return Right(popularLocation);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, RecentlyAllModel>> getRecentlyAll(
      {required PaginationParams parms}) async {
    try {
      final recentlyAll = await homeBuyerDatasource.getRecentlyAll(
        token: appRepository.loadAppData()!.token.toString(),
        parms: parms,
      );

      // await local.listingsDatasource(token: user.body.accessToken.toString());
      return Right(recentlyAll);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, SearchModel>> getSearchandFilter(
      {required SearchAndFilterParams searchAndFilterParams,
      required String page}) async {
    try {
      final searchData = await homeBuyerDatasource.getSearchData(
        token: appRepository.loadAppData()!.token.toString(),
        params: searchAndFilterParams,
        page: page,
      );
      return Right(searchData);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, ProjectModel>> getProjectDetails(
      {required ProjectParams parms}) async {
    try {
      final projectData = await homeBuyerDatasource.getProjectData(
        token: appRepository.loadAppData()!.token.toString(),
        params: parms,
      );
      return Right(projectData);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
