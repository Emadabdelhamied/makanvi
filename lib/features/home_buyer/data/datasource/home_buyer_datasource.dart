import 'dart:developer';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/util/api_basehelper.dart';
import '../../../../../core/util/end_points.dart';
import '../../domain/usecase/get_feature_all_usecase.dart';
import '../../domain/usecase/get_project_details_usecase.dart';
import '../../domain/usecase/search_and_filter_usecase.dart';
import '../models/feature_all_model.dart';
import '../models/home_buer_model.dart';
import '../models/popular_location_model.dart';
import '../models/project_model.dart';
import '../models/recently_all_model.dart';
import '../models/search_model.dart';

abstract class HomeBuyerDatasource {
  Future<HomeBuyerModel> getHomeBuyer({
    required String token,
  });
  Future<PopularLocationModel> getPopularLocation({
    required String token,
    required PaginationParams parms,
  });
  Future<FeatureAllModel> getFeatureAll(
      {required String token, required PaginationParams parms});
  Future<RecentlyAllModel> getRecentlyAll(
      {required String token, required PaginationParams parms});
  Future<SearchModel> getSearchData(
      {required String token,
      required SearchAndFilterParams params,
      required String page});
  Future<ProjectModel> getProjectData({
    required String token,
    required ProjectParams params,
  });
}

class HomeBuyerDatasourceImpl implements HomeBuyerDatasource {
  ApiBaseHelper apiConsumer;

  HomeBuyerDatasourceImpl({required this.apiConsumer});

  @override
  Future<HomeBuyerModel> getHomeBuyer({required String token}) async {
    String url = "home/buyer";

    log(url);
    try {
      final response = await apiConsumer.get(
        url: "${EndPoints.baseUrl}$url",
        token: token,
      );
      HomeBuyerModel homeBuyerModel = HomeBuyerModel.fromJson(response);
      if (response == null) {
        throw ServerException(message: response["message"]);
      } else {
        return homeBuyerModel;
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<FeatureAllModel> getFeatureAll(
      {required String token, required PaginationParams parms}) async {
    String url = "property/list/featured?page=${parms.page}";

    log(url);
    try {
      final response = await apiConsumer.get(
        url: "${EndPoints.baseUrl}$url",
        token: token,
      );
      FeatureAllModel featureAllModel = FeatureAllModel.fromJson(response);
      if (response == null) {
        throw ServerException(message: response["message"]);
      } else {
        return featureAllModel;
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<PopularLocationModel> getPopularLocation({
    required String token,
    required PaginationParams parms,
  }) async {
    String url = "popular_locations?page=${parms.page}";

    log(url);
    try {
      final response = await apiConsumer.get(
        url: "${EndPoints.baseUrl}$url",
        token: token,
      );
      PopularLocationModel popularLocationModel =
          PopularLocationModel.fromJson(response);
      if (response == null) {
        throw ServerException(message: response["message"]);
      } else {
        return popularLocationModel;
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<RecentlyAllModel> getRecentlyAll(
      {required String token, required PaginationParams parms}) async {
    String url = "property/list/recently?page=${parms.page}";

    log(url);
    try {
      final response = await apiConsumer.get(
        url: "${EndPoints.baseUrl}$url",
        token: token,
      );
      RecentlyAllModel recentlyAllModel = RecentlyAllModel.fromJson(response);
      if (response == null) {
        throw ServerException(message: response["message"]);
      } else {
        return recentlyAllModel;
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<SearchModel> getSearchData(
      {required String token,
      required SearchAndFilterParams params,
      required String page}) async {
    String url = "property/filter?page=$page";
    try {
      final response = await apiConsumer
          .post(url: "${EndPoints.baseUrl}$url", token: token, body: {
        "search": params.search,
        "offer_type_id": params.offerTypeId == '0' ? null : params.offerTypeId,
        "price_from": params.priceFrom,
        "price_to": params.priceTo,
        "area_from": params.areaFrom,
        "area_to": params.areaTo,
        "types[]": params.types,
        "amenities[]": params.amenities,
        "features": params.features.map((x) => x.toJson()).toList(),
        "popular_location_id": params.locationId,
      });
      SearchModel searchModel = SearchModel.fromJson(response);
      if (response == null) {
        throw ServerException(message: response["message"]);
      } else {
        return searchModel;
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<ProjectModel> getProjectData(
      {required String token, required ProjectParams params}) async {
    try {
      final response = await apiConsumer.get(
        url: "${EndPoints.baseUrl}projects/${params.id}",
        token: token,
      );
      ProjectModel projectModel = ProjectModel.fromJson(response);
      if (response == null) {
        throw ServerException(message: response["message"]);
      } else {
        return projectModel;
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }
}
