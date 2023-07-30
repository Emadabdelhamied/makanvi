import 'dart:developer';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/util/api_basehelper.dart';
import '../../../../../core/util/end_points.dart';
import '../../domain/usecases/close_property_usecase.dart';
import '../../domain/usecases/create_listings_usecase.dart';
import '../../domain/usecases/direct_upgrade_usecase.dart';
import '../../domain/usecases/edit_listing_usecase.dart';
import '../../domain/usecases/get_listing_data_usecase.dart';
import '../../domain/usecases/rate_shotting_usecase.dart';
import '../models/my_listing_model.dart';
import '../models/my_listings_all_model.dart';

abstract class ListingsDatasource {
  Future<String> createListing(
      {required CreateListingParms createListingParms, required String token});
  Future<String> closeProperty(
      {required ClosePropertyParams closePropertyParams,
      required String token});
  Future<String> directUpgrading(
      {required DirectUpgradeParams directUpgradeParams,
      required String token});
  Future<String> editProperty(
      {required EditListingDataParams editListingDataParams,
      required String token});
  Future<MyListingModel> getMyListingById(
      {required GetListingDataParams getListingDataParams,
      required String token});
  Future<GetMyListigsAllModel> getListingsAll({required String token});
  Future<String> rateShotting(
      {required String token, required RatingShootParams ratingShootParams});
}

class ListingsDatasourceImpl implements ListingsDatasource {
  ApiBaseHelper apiConsumer;

  ListingsDatasourceImpl({required this.apiConsumer});

  @override
  Future<String> createListing(
      {required CreateListingParms createListingParms,
      required String token}) async {
    Map<String, dynamic> addListingParms =
        createListingParms.creatListingsModel!;
    log(addListingParms.toString());
    // addListingParms
    //     .addAll({"amenities": createListingParms.amenitiesPars!.toList()});
    // addListingParms.addAll({"features": createListingParms.featuresPars!});

    try {
      final response = await apiConsumer.post(
          url: "${EndPoints.baseUrl}property",
          token: token,
          body: createListingParms.creatListingsModel!);
      if (response["message"] == null) {
        throw ServerException(message: response["message"]);
      } else {
        return response["listing_id"].toString();
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<GetMyListigsAllModel> getListingsAll({required String token}) async {
    try {
      final response = await apiConsumer.get(
        url: "${EndPoints.baseUrl}property",
        token: token,
      );
      GetMyListigsAllModel getMyListigsAllModel =
          GetMyListigsAllModel.fromJson(response);
      if (response["properities"] == null) {
        throw ServerException(message: response["message"]);
      } else {
        return getMyListigsAllModel;
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<String> directUpgrading(
      {required DirectUpgradeParams directUpgradeParams,
      required String token}) async {
    try {
      final response = await apiConsumer.post(
          url: "${EndPoints.baseUrl}payment/direct/upgrade",
          token: token,
          body: {
            "package_id": directUpgradeParams.packageId,
            "listing_id": directUpgradeParams.listingId,
          });
      if (response["message"] == null) {
        throw ServerException(message: response["message"]);
      } else {
        return response["message"];
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<MyListingModel> getMyListingById(
      {required GetListingDataParams getListingDataParams,
      required String token}) async {
    try {
      final response = await apiConsumer.get(
        url: "${EndPoints.baseUrl}property/${getListingDataParams.listingId}",
        token: token,
      );
      if (response["property"] == null) {
        throw ServerException(message: response["message"]);
      } else {
        return MyListingModel.fromJson(response);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<String> editProperty(
      {required EditListingDataParams editListingDataParams,
      required String token}) async {
    try {
      final response = await apiConsumer.put(
        url: "${EndPoints.baseUrl}property/${editListingDataParams.listingId}",
        token: token,
        body: {
          "offer_type_id": editListingDataParams.selectedOfferType,
          "type_id": editListingDataParams.selectedType,
          "area": editListingDataParams.area,
          "price": editListingDataParams.price,
          "amenities": editListingDataParams.amenities,
          "features": editListingDataParams.features,
          "is_negotiable": editListingDataParams.isNegotiable,
          // "recommended_shooting_date": editListingDataParams.date,
          "country": editListingDataParams.country,
          "state": editListingDataParams.state,
          "city": editListingDataParams.city,
          "country_ar": editListingDataParams.countryAr,
          "state_ar": editListingDataParams.stateAr,
          "city_ar": editListingDataParams.cityAr,
          "currency": editListingDataParams.currency,
          "latitude": editListingDataParams.latitude,
          "longitude": editListingDataParams.longitude,
          "description_ar": editListingDataParams.description,
          "description_en": editListingDataParams.description,
        },
      );
      if (response == null) {
        throw ServerException(message: response["message"]);
      } else {
        return response["message"];
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<String> closeProperty(
      {required ClosePropertyParams closePropertyParams,
      required String token}) async {
    try {
      final response = await apiConsumer.get(
        url:
            "${EndPoints.baseUrl}property/close/${closePropertyParams.listingId}",
        token: token,
      );
      if (response["message"] == null) {
        throw ServerException(message: response["message"]);
      } else {
        return response["message"];
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<String> rateShotting(
      {required String token,
      required RatingShootParams ratingShootParams}) async {
    try {
      final response = await apiConsumer.post(
        url: "${EndPoints.baseUrl}property/rate_shooting",
        token: token,
        body: {
          "_method": "PUT",
          "rate": ratingShootParams.rate,
          "review": ratingShootParams.review,
          "property_id": ratingShootParams.propertyId
        },
      );
      if (response["message"] == null) {
        throw ServerException(message: response["message"]);
      } else {
        return response["message"];
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }
}
